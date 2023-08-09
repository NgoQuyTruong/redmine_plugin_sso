# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
# frozen_string_literal: true

Rails.application.routes.draw do
    get 'vareal/login', to: 'vareal_id#index', as: 'vareal_id'
    get 'vareal/callback', to: 'vareal_id#callback', as: 'vareal_id_callback'
end
