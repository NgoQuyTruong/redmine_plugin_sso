# frozen_string_literal: true

class VarealIdController < ApplicationController
  before_action :fetch_env_variables
  def index;end

  def callback
    return if params[:code].nil?
    url = "#{@vareal_id_url}/api/v1/oauth2/me"
    @user_data = HTTParty.get(url, body: { code: params[:code] }.to_json, headers: { 'Content-Type': 'application/json'})
    handle_authenticate_fail if @user_data.nil? || @user_data.blank?

    url_auth = "#{@vareal_id_url}/api/v1/oauth2/auth"
    user_info =  HTTParty.post(url_auth, body: { code: params[:code] }.to_json,
      headers: { 'Content-Type': 'application/json', 'X-User-Id': @user_data.dig('users', 'uid')})

    handle_authenticate_failure unless user_info.dig('success')

    user_email = @user_data.dig('users', 'email')
    user_name = @user_data.dig('users', 'name')
    role_admin = @user_data.dig('users', 'role') == 'admin'
    first_name = first_name = user_email.split('@')[0]
    user_target = EmailAddress.find_by(address: user_email)
    user_login = if user_target.present?
                    user_target.user
                  else
                    User.create!(
                      login: "#{first_name}_vareal",
                      firstname: 'vareal',
                      lastname: first_name,
                      mail: user_email,
                      admin: role_admin,
                      password: 'Aa@123456',
                    )
                  end
    handle_authenticate_failure unless user_login
    handle_active_user user_login
    session['id_token'] = user_info.dig('id_token')
    session['x_user_id'] = @user_data.dig('users', 'uid')
    # try_to_autologin user_target
    respond_to do |format|
      format.html
    end
  end

  private
    def handle_authenticate_fail
      @response = {root_path: home_path, message: 'Authentication failed'}
      flash.now[:danger] = 'Authenticate failed'
      return
    end

    def handle_authenticate_success
      @response = {root_path: home_path, message: 'Authentication successful'}
    end

    def handle_active_user(user)
      successful_authentication(user)
      update_sudo_timestamp! # activate Sudo Mode
    end

    def successful_authentication(user)
      logger.info "Successful authentication for '#{user.login}' from #{request.remote_ip} at #{Time.now.utc}"
      # Valid user
      self.logged_user = user
      # generate a key and set cookie if autologin
      if params[:autologin] && Setting.autologin?

        set_autologin_cookie(user)
      end
      # call_hook(:controller_account_success_authentication_after, {:user => user})
      redirect_back_or_default my_page_path
    end

    def handle_authenticate_failure
      flash['error'] = 'Something went wrong'
      redirect_back_or_default my_page_path
    end

    def fetch_env_variables
      @vareal_id_url = Setting.plugin_redmine_vareal_id['VAREAL_ID_BASE_URL']
      @service_id = Setting.plugin_redmine_vareal_id['SERVICE_ID']
      @client_id = Setting.plugin_redmine_vareal_id['CLIENT_ID']
    end
end
