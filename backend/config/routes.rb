Rails.application.routes.draw do
  root 'jogging_times#index'

  namespace :authentication do
    get '', action: :login, as: :login
    post '', action: :login_post, as: :login_post
    delete '', action: :logout, as: :logout
  end
end
