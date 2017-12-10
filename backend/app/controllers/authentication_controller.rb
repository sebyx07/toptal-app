class AuthenticationController < ApplicationController
  def login_post
    @username = params[:username]
    login = AuthenticationService::Login.new(params: params).process

    if login.authenticated
      set_session(login.user)
      flash[:success] = 'Welcome'
      redirect_to_dashboard(login.user)
    else
      render :login
    end
  end

  def register_post
    @username = params[:username]
    @password = params[:password]

    register = AuthenticationService::Register.new(params).process

    if register.user
      set_session(register.user)
      redirect_to root_path
    else
      render :register
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    if current_admin.present?
      redirect_to users_path
    else
      redirect_to authentication_login_path
    end
  end

  def logout_admin
    session[:admin_id] = nil
    flash[:success] = 'Logged out from admin'
    redirect_to authentication_login_path
  end

  def redirect_to_dashboard(user=current_user)
    return if user.nil?

    if user.basic?
      redirect_to root_path
    else
      redirect_to users_path
    end
  end

  def set_session(user)
    if user.basic? || user.manager?
      session[:user_id] = user.id
    elsif user.admin?
      session[:admin_id] = user.id
    end
  end
end