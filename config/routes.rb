Rails.application.routes.draw do

  get 'set_tracking',                           to: 'set_tracking#index'
  post 'set_tracking',                          to: 'set_tracking#create'
  get 'set_tracking/set_hsts_header/:duration', to: 'set_tracking#set_hsts_header'

  get 'show_tracking',                                       to: 'show_tracking#collect_data'
  get 'show_tracking/display_data',                          to: 'show_tracking#display_data'
  get 'show_tracking/check_hsts/:index/:tracked_session_id', to: 'show_tracking#check_hsts'

  devise_for :users
  root 'base#index'

  get 'base/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
