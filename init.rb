# frozen_string_literal: true

require 'redmine'
require File.expand_path('lib/hook_v_id', __dir__)

ApplicationController.include VarealControllerSsoPatch

Redmine::Plugin.register :redmine_vareal_id do
  name 'Redmine Vareal ID'
  author 'Vareal'
  description 'A plugin to connect with Vareal ID'
  version '0.0.1'
  url 'https://www.vareal.vn'
  author_url 'https://www.vareal.vn'

  settings :default => {
    'SERVICE_ID' => '25098aa801f9dd1a5c99',
    'CLIENT_ID' => '81c77f9a5c2fae29e032',
    'VAREAL_ID_BASE_URL' => 'https://stg.id.vareal.net'
  }, :partial => 'settings/redmine_vareal_id_settings'

  menu :account_menu, :vareal_id, { controller: 'vareal_id', action: 'index' }, caption: '', before: :my_account
end
