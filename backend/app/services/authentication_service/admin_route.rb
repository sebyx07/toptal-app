module AuthenticationService
  class AdminRoute
    def matches?(request)
      return false unless request.session[:staff_id]
      User.find_by(id: request.session[:staff_id])&.admin?
    end
  end
end