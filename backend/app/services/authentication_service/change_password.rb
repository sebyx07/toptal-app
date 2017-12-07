module AuthenticationService
  class ChangePassword
    include ActiveModel::Validations
    attr_reader :old_password, :password, :password_repeat, :current_user
    attr_accessor :changed
    validate :passwords_match, :correct_old_password
    validates :old_password, presence: true
    validates :password, presence: true, length: {
        minimum: 8,
        maxiumum: 32
    }

    def initialize(params = {}, current_user)
      @old_password = params[:old_password]
      @password = params[:password]
      @password_repeat = params[:password_repeat]
      @current_user = current_user
    end

    def process
      if valid?
        current_user.password = password
        current_user.save
        self.changed = true
      end
      self
    end

    def correct_old_password
      unless current_user.authenticate(old_password)
        errors.add(:old_password, 'Parola veche este incorecta')
      end
    end

    def passwords_match
      if password != password_repeat
        errors.add(:password_repeat, 'Parolele nu se potrivesc')
      end
    end
  end
end