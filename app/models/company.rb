class Company < ActiveRecord::Base
  has_many :users
  has_many :taxis, through: :users

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :contact_person, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
end
