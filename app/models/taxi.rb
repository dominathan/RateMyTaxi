class Taxi < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :user_id, presence: true
  validates :driver_id, presence: true
  validates :driver_first_name, presence: true
  validates :driver_last_name, presence: true



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

  def self.most_review_answers(user)
    taxi_list = user.taxis.collect!(&:id)
    total_count = []
    for taxi in taxi_list
      total_count << Answer.where(taxi_id: taxi).count
    end
    taxi_sorted_by_total_answers = total_count.zip(taxi_list).sort
    return taxi_sorted_by_total_answers
  end
end
