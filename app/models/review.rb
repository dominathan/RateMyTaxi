class Review < ActiveRecord::Base
  belongs_to :taxi
  has_many :questions
  accepts_nested_attributes_for :questions,  :reject_if => :all_blank
end
