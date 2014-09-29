class Rider < ActiveRecord::Base
  belongs_to :company

  validate :email, presence: true

  def self.get_company_id(taxi_id)
    user_id = Taxi.find_by(id: taxi_id).user_id
    company_id = User.find_by(id: user_id).company_id
    return company_id
  end
end
