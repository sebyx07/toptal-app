module AuthenticationService
  class Login < OpenStruct
    def process
      self.user = User.find_by(username: params[:username]&.downcase)
      if user && user.authenticate(params[:password])
        self.authenticated = true
      end
      self
    end
  end
end