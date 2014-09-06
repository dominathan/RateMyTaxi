class User < ActiveRecord::Base
  has_many :reviews
  has_many :taxis
  has_many :taxi
end
