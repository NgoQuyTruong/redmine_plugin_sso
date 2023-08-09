# frozen_string_literal: true

module VarealControllerSsoPatch
  def self.included(base)
    base.class_eval do
      before_action :fetch_list_services
      def fetch_list_services
        token_id = session['id_token']
        x_user_id = session['x_user_id']
        current_user_lg = User.current.login
        return [] unless current_user_lg.present? || token_id.present? || x_user_id.present?
        @vareal_id_url = Setting.plugin_redmine_vareal_id['VAREAL_ID_BASE_URL']
        @client_id = Setting.plugin_redmine_vareal_id['CLIENT_ID']
        service_id = Setting.plugin_redmine_vareal_id['SERVICE_ID']
        url = "#{@vareal_id_url}/api/v1/services?id_token=#{token_id}&service_id=#{service_id}"
        @services = HTTParty.get(url, headers: { 'Content-Type': 'application/json', 'X-User-Id': x_user_id})
      rescue => e
        flash['error'] = 'Something went wrong'
      end
    end
  end
end
