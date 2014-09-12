class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer

  #for bar chart of indiviudal taxis with question.answer_types = '1-5'
  def self.numerical_histogram(taxi_id,question_id)
    all_answer_for_taxi = Answer.where(taxi_id: taxi_id, question_id: question_id).load
    return [all_answer_for_taxi.where(content: '1').count,all_answer_for_taxi.where(content: '2').count,
            all_answer_for_taxi.where(content: '3').count,all_answer_for_taxi.where(content: '4').count,
            all_answer_for_taxi.where(content: '5').count]
  end
  #for bar chart of indiviudal taxis with question.answer_types = 'Yes/No'
  def self.yes_no_histogram(taxi_id,question_id)
    all_answer_for_taxi = Answer.where(taxi_id: taxi_id, question_id: question_id).load
    return [all_answer_for_taxi.where(content: 'Yes').count,
            all_answer_for_taxi.where(content: 'No').count]
  end

  #for all question and answer data...1-5 questions
  def self.sum_numerical_histogram(user,question_id)
    taxi_list = user.taxis.collect!(&:id)
    all_answers_for_company = Answer.where(question_id: question_id, taxi_id: taxi_list)
    return [all_answers_for_company.where(content: '1').count,all_answers_for_company.where(content: '2').count,
            all_answers_for_company.where(content: '3').count,all_answers_for_company.where(content: '4').count,
            all_answers_for_company.where(content: '5').count]
  end

  #for all question and answer data...yes no questions
  def self.sum_yes_no_histogram(user,question_id)
    taxi_list = user.taxis.collect!(&:id)
    all_answers_for_company = Answer.where(question_id: question_id, taxi_id: taxi_list)
    return [all_answers_for_company.where(content: 'Yes').count,
            all_answers_for_company.where(content: 'No').count]
  end


end
