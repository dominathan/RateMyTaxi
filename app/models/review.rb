class Review < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  accepts_nested_attributes_for :questions,
                              :reject_if => lambda { |question| question[:content].empty? ||
                                                             question[:answer_type].empty? },
                              :allow_destroy => true
end
