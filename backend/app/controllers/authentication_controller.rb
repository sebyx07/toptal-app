class AuthenticationController < ApplicationController
  def login_post
    @username = params[:username]
    login = AuthenticationService::Login.new(params: params).process

    if login.authenticated
      set_session(login.user)
      flash[:success] = 'Welcome'
      redirect_to_dashboard(login.user)
    else
      flash[:error] = 'Incorrect Login'
      render :login
    end
  end

  def register_post
    @username = params[:username]
    @password = params[:password]

    register = AuthenticationService::Register.new(params).process

    if register.user
      set_session(register.user)
      flash[:success] = 'Welcome'
      redirect_to dashboard_path
    else
      flash[:error] = register.errors.full_messages
      render :register
    end
  end

  def logout
    session[:user_id] = nil
    if session[:staff_id].present?
      session[:staff_id] = nil
    end
    redirect_to authentication_login_path
  end

  def change_password
    change_password_service = AuthenticationService::ChangePassword.new(params, current_user).process
    if change_password_service.changed
      flash[:success] = 'Parola A Fost Schimbata'
    else
      flash[:error] = change_password_service
    end
    redirect_to dashboard_users_path
  end

  def _verify_recaptcha
    return if Rails.env.test?
    unless verify_recaptcha
      flash[:error] = 'Recaptcha Invalida'
      redirect_to authentication_login_path
    end
  end

  def redirect_to_dashboard(user=current_user)
    return if user.nil?
    if user.basic?
      redirect_to dashboard_path
    elsif user.staff? || user.admin?
      redirect_to staff_path
    end
  end

  def set_session(user)
    if user.basic?
      session[:user_id] = user.id
    else
      session[:staff_id] = user.id
    end
  end
end