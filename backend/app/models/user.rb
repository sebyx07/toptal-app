class User < ApplicationRecord
  has_secure_password
  enum role: [:basic, :manager, :admin]
end
