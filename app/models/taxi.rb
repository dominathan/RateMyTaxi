class Taxi < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :user_id, presence: true
  validates :driver_id, presence: true

  #master list of all taxi ids
  IDLIST = Taxi.all.collect(&:id)

  #randomly generate 6 digit id number to find taxi
  def self.set_taxi_id(id_list, new_taxi)
    idnum = Random.rand(100000..999999)
    if id_list.length == 0
      idnum = 100000
    end
    if id_list.include?(idnum)
      set_taxi_id(id_list, new_taxi)
    else
      new_taxi.id = idnum
      id_list.push(idnum)
    end
  end

  def self.full_name(user)
    [user.driver_first_name, user.driver_last_name].compact.join(" ")
  end

  #return list of taxis with number of answers received(date-range options = {})
  def self.most_review_answers(user, options = {})
    taxi_list = user.taxis.collect!(&:id)
    total_count = []
    date_start = options["date_start"].to_date.beginning_of_day unless options['date_start'] == nil
    date_end = options["date_end"].to_date.end_of_day unless options['date_end'] == nil
    for taxi in taxi_list
      unless options['date_start'] == nil
        total_count << Answer.where(taxi_id: taxi).where(:created_at => date_start..date_end).count
      else
        total_count << Answer.where(taxi_id: taxi).count
      end
    end
    taxi_sorted_by_total_answers = total_count.zip(taxi_list)
    return taxi_sorted_by_total_answers
  end

  #return the avg rating of a taxi driver based on the collected ratings of all questions
    #with answer_type == 1-5 (date-range is options = {})
  def self.highest_rated_driver(user, options = {})
    taxi_list = user.company.taxis.collect(&:id)
    date_start = options["date_start"].to_date.beginning_of_day unless options['date_start'] == nil
    date_end = options["date_end"].to_date.end_of_day unless options['date_end'] == nil
    question_list = Question.array_of_numerical_questions(user)
    total_count = []
    for taxi in taxi_list
      unless options['date_start'] == nil
        all_answers = Answer.where(question_id: question_list, taxi_id: taxi).where(:created_at =>
                                                          date_start..date_end).collect(&:content).map(&:to_i)
        total_value = all_answers.inject(0, :+)
        if all_answers.length > 0
          avg_rating = (total_value.to_f / all_answers.length).round(1)
        else
          #skip taxis with 0 answers to questions
          avg_rating = 0
        end
      else
        all_answers = Answer.where(question_id: question_list, taxi_id: taxi).collect(&:content).map(&:to_i)
        total_value = all_answers.inject(0, :+)
        if all_answers.length > 0
          avg_rating = (total_value.to_f / all_answers.length).round(1)
        else
          #skip taxis with 0 answers to questions
          avg_rating = 0
        end
      end
      total_count << avg_rating
    end
    taxi_with_avg_rating = total_count.zip(taxi_list)
    return taxi_with_avg_rating
  end


end
