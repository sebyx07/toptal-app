class User < ApplicationRecord
  enum role: [:basic, :manager, :admin]
end
