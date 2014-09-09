class Question < ActiveRecord::Base
  belongs_to :review
  has_many :answers
  accepts_nested_attributes_for :answers

  ANSWER_TYPES = ['1-5','Yes/No','Number Response','Text Response']


end
