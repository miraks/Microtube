class User < ActiveRecord::Base
  attr_readonly :login

  validates :login, length: 4..16
end
