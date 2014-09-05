class User < ActiveRecord::Base
  has_many :taxis
  has_many :taxi
end
