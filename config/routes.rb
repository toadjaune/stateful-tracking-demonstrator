Rails.application.routes.draw do

  get 'set_tracking',     to: 'set_tracking#index'
  post 'set_tracking',    to: 'set_tracking#create'
  get 'show_tracking',    to: 'show_tracking#index'

  devise_for :users
  root 'base#index'

  get 'base/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
