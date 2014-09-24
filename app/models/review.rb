class Review < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  accepts_nested_attributes_for :questions,
                              :reject_if => lambda { |question| question[:content].empty? ||
                                                             question[:answer_type].empty? },
                              :allow_destroy => true

  #This review is created for each user on sign-up
  def self.initial_review(current_user)
    new_review = Review.new
    new_review.name = "Standard Review Template"
    new_review.user_id = current_user.id
    new_review.use_this_review = 1
    new_review.save
    review_id = new_review.id
    q1 = Question.new(
                    content: "What was the date of your cab ride?",
                    answer_type: 'Date')
    q1.review_id = review_id
    q1.save
    q2 = Question.new(
                      content: "Approximately would time was your cab ride?",
                      answer_type: 'Time')
    q2.review_id = review_id
    q2.save
    q3 = Question.new(
                      content: "How would you rate the appearance of your cab?",
                      answer_type: '1-5')
    q3.review_id = review_id
    q3.save
    q4 = Question.new(
                      content: "How would you rate your experience with your driver?",
                      answer_type: '1-5')
    q4.review_id = review_id
    q4.save
    q5 = Question.new(
                      content: "Anything else you would like to add?",
                      answer_type: 'Text Response')
    q5.review_id = review_id
    q5.save
  end

end
