class Question < ActiveRecord::Base
  belongs_to :review
  has_many :answers
end
