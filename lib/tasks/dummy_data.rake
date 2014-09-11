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

  desc 'make 1 Review'
  task populate: :environment do
    Review.create!(name: 'Sample Review',
                    user_id: 1)
  end

  desc 'add 4 questions of each type to Review'
  task populate: :environment do
    i = 0
    4.times do |n|
      Question.create!(review_id: 1,
                        content: Faker::Lorem.sentence,
                        answer_type: Question::ANSWER_TYPES[i])
      i +=1
    end
  end

  desc 'add 500 answers to different taxis and questions'
  task populate: :environment do
    list = Taxi.all.collect(&:id)
    500.times do |n|
      question_id = Random.rand(1..4)
      if question_id == 1
        content = Random.rand(1..5)
      elsif question_id == 2
        content_choice = ['Yes','No']
        content = content_choice[Random.rand(0..1)]
      elsif question_id == 3
        content = Random.rand(1..90)
      else
        content = Faker::Lorem.sentence
      end
      taxi_id = list[Random.rand(0..49)]
      Answer.create!(question_id: question_id,
                     content: content,
                     taxi_id: taxi_id)
    end
  end




end