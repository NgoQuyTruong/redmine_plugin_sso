# frozen_string_literal: true

class HookVId < Redmine::Hook::ViewListener
  render_on :view_layouts_base_body_bottom,
            :partial => 'hooks/v_id_template'
  render_on :view_account_login_bottom,
            :partial => 'hooks/view_account_login_bottom'
end
