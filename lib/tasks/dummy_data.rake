namespace :db do

  desc 'add users to database'
  task populate: :environment do
    password = "password"
    User.create!(email: "test@test.com",
                 password: password,
                 password_confirmation: password,
                 company_name: "Cville Cab Company",
                 taxi_count: 50)
  end


  desc 'add 50 taxi drivers'
  task populate: :environment do
    50.times do |n|
      driver_first_name = Faker::Name.first_name
      driver_last_name = Faker::Name.last_name
      Taxi.create!(driver_first_name: driver_first_name,
                    driver_last_name: driver_last_name,
                    id: Random.rand(100000..999999),
                    driver_id: "VA 4HLFSD3",
                    user_id: 1)
    end
  end






end
