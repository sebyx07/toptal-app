module UserService
  class Update < OpenStruct
    def process
      self.user = User.find_by(id: params[:id])
      return false if user.nil?
      p params.permit(:username, :role)
      user.update!(params.permit(:username, :role))
      self
    end
  end
end