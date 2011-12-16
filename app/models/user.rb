class User < ActiveRecord::Base
  acts_as_authentic

  has_many :videos

  attr_readonly :login

  validates :login, length: 4..16
end
