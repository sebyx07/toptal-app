module UserService
  class Create < UserService::Update
    def process
      if params[:password] != params[:password_repeat]
        return false
      end

      self.user = User.create!(params.permit(:username, :password, :role))


      self
    end
  end
end