class Taxi < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :user_id, presence: true



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

end
