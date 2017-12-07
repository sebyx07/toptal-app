module AuthenticationService
  class Register
    include ActiveModel::Validations
    attr_reader :username, :password, :password_repeat
    attr_accessor :user
    validate :unique_username, :passwords_match
    validates :username, presence: true, length: {
        minimum: 4,
        maxiumum: 32
    }

    validates :password, presence: true, length: {
        minimum: 8,
        maxiumum: 32
    }

    def initialize(params = {})
      @username = params[:username]&.downcase
      @password = params[:password]
      @password_repeat = params[:password_repeat]
    end

    def process
      if valid?
        self.user = User.create(username: username, password: password, role: :basic)
      end
      self
    end

    def unique_username
      if User.find_by(username: username)
        errors.add(:username, 'exista utilizator cu acest username deja')
      end
    end

    def passwords_match
      if password != password_repeat
        errors.add(:password_repeat, 'Parolele nu se potrivesc')
      end
    end
  end
end