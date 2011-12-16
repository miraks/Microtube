class User < ActiveRecord::Base
  acts_as_authentic

  attr_readonly :login

  validates :login, length: 4..16
end
