class Question < ActiveRecord::Base
  belongs_to :review
  has_many :answers
  accepts_nested_attributes_for :answers

  ANSWER_TYPES = ['1-5','Yes/No','Number Response','Text Response']

  #return array of question_ids with q.answer_type = 1-5
  def self.array_of_numerical_questions(user)
    return user.reviews.last.questions.where(answer_type: '1-5').collect!(&:id).uniq
  end

  #return array of question_ids with q.answer_type = 'Yes/No'
  def self.array_of_yes_no_questions(user)
    return user.reviews.last.questions.where(answer_type: 'Yes/No').collect!(&:id).uniq
  end

  #return DB tables of yes/no && 1-5 questions
  def self.numerical_and_yes_no_tables(user)
    user.reviews.last.questions.where(answer_type: ['1-5', "Yes/No"]).order(:id)
  end

  def self.numerical_ids(user)
    user.reviews.last.questions.where(answer_type: ['1-5']).collect(&:id)
  end

  def self.yes_no_ids(user)
    user.reviews.last.questions.where(answer_type: ['Yes/No']).collect(&:id)
  end





end
