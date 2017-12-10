class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    return @current_user if @current_user.present?
    return nil if session[:user_id].nil?
    id = session[:user_id]
    @current_user = User.find_by(id: id)
  end

  def current_admin
    return @current_admin if @current_admin.present?
    return nil if session[:admin_id].nil?
    admin = User.find_by(id: session[:admin_id])
    if admin&.admin?
      @current_admin = admin
    end
  end

  def require_current_user
    if current_user.nil? || !current_user.basic?
      redirect_to authentication_login_path
    end
  end

  def require_current_manager
    if current_user&.basic?
      redirect_to authentication_login_path
    end
  end

  def require_current_admin
    if current_admin.nil?
      redirect_to authentication_login_path
    end
  end

  protected :require_current_user, :require_current_manager, :require_current_admin

  helper_method :current_user, :current_admin
end
