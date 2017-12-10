Rails.application.routes.draw do
  root 'jogging_times#index'

  namespace :authentication do
    get '', action: :login, as: :login
    get 'register', action: :register, as: :register
    post 'register', action: :register_post, as: :register_post
    post '', action: :login_post, as: :login_post
    delete '', action: :logout, as: :logout
    delete '/admin', action: :logout_admin, as: :logout_admin
  end

  resources :jogging_times, only: [:update, :create, :destroy, :show] do

  end

  resources :jogging_time_reports, only: [:index, :show]

  resources :users do
    post '/login_as_user', action: :login_as_user, as: :login_as_user
  end
end
