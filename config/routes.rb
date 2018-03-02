Rails.application.routes.draw do

  get 'etag/index'

  get  'set_tracking',                          to: 'set_tracking#prepare'
  post 'set_tracking',                          to: 'set_tracking#track'
  get 'set_tracking/set_hsts_header/:duration', to: 'set_tracking#set_hsts_header'

  get 'show_tracking',                                       to: 'show_tracking#collect_data'
  get 'show_tracking/display_data',                          to: 'show_tracking#display_data'
  get 'show_tracking/check_hsts/:index/:tracked_session_id', to: 'show_tracking#check_hsts'
  get 'show_tracking/check_local_storage/',                  to: 'show_tracking#check_local_storage'

  get 'etag',   to: 'etag#index'

  post 'hpkp-report',   to: 'hpkp#report'

  devise_for :users
  # Since we disabled rails normal js, we can't use the DELETE route, so we need a GET one
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end


  root 'base#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
