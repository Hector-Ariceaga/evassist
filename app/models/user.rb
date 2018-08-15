class User < ActiveRecord::Base
  has_many :events
  has_many :tasks, through: :events
  has_secure_password

end
