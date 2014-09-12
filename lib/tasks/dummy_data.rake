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
    Review.create!(name: 'Cville Cab Review',
                    user_id: 1)
  end

  desc 'add 4 questions of each type to Review'
  task populate: :environment do
    Question.create!(review_id: 1,
                      content: "How would you rate your overall taxi experience (5 being the highest)?",
                      answer_type: '1-5')
    Question.create!(review_id: 1,
                      content: "How would you rate your driver (5 being the highest)?",
                      answer_type: '1-5')
    Question.create!(review_id: 1,
                      content: "Did you make it to your destination on time?",
                      answer_type: 'Yes/No')
    Question.create!(review_id: 1,
                      content: "Would you ride with us again?",
                      answer_type: 'Yes/No')
    Question.create!(review_id: 1,
                      content: "Anything else you would like to add?",
                      answer_type: 'Text Response')
  end

  desc 'add 1000 answers to different taxis and questions'
  task populate: :environment do
    list = Taxi.all.collect(&:id)
    1000.times do |n|
      question_id = Random.rand(1..5)
      if question_id == 1 || question_id == 2
        content = Random.rand(1..5)
      elsif question_id == 3 || question_id == 4
        content_choice = ['Yes','No']
        content = content_choice[Random.rand(0..1)]
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
