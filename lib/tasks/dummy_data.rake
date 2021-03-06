namespace :db do

  desc 'add users to database'
  task populate: :environment do
    password = "password"
    User.create!(email: "test@test.com",
                 password: password,
                 password_confirmation: password,
                 company_name: "Cville Cab Company",
                 taxi_count: 50)
    User.create!(email: "nathan@test.com",
                 password: password,
                 password_confirmation: password,
                 company_name: "Nathan Cab Company",
                 taxi_count: 50)
  end


  desc 'add 50 taxi drivers'
  task populate: :environment do
    o = [('A'..'Z'),(0..9)].map { |i| i.to_a }.flatten
    50.times do |n|
      license = (0..6).map { o[rand(o.length)] }.join
      driver_first_name = Faker::Name.first_name
      driver_last_name = Faker::Name.last_name
      Taxi.create!(driver_first_name: driver_first_name,
                    driver_last_name: driver_last_name,
                    id: Random.rand(100000..999999),
                    driver_id: "VA "+license.to_s,
                    user_id: 1)
    end
    50.times do |n|
      license = (0..6).map { o[rand(o.length)] }.join
      driver_first_name = Faker::Name.first_name
      driver_last_name = Faker::Name.last_name
      Taxi.create!(driver_first_name: driver_first_name,
                    driver_last_name: driver_last_name,
                    id: Random.rand(100000..999999),
                    driver_id: "VA "+license.to_s,
                    user_id: 2)
    end
  end

  desc 'make 1 Review'
  task populate: :environment do
    Review.create!(name: 'Standard Template',
                    user_id: 1)
    Review.create!(name: 'Nathan Cab Review',
                    user_id: 2)
  end

  desc 'add 4 questions of each type to Review'
  task populate: :environment do
    Question.create!(review_id: 1,
                      content: "What was the date of your cab ride?",
                      answer_type: 'Date')
    Question.create!(review_id: 1,
                      content: "Approximately would time was your cab ride?",
                      answer_type: 'Time')
    Question.create!(review_id: 1,
                      content: "How would you rate the appearance of your cab?",
                      answer_type: '1-5')
    Question.create!(review_id: 1,
                      content: "How would you rate your experience with your driver?",
                      answer_type: '1-5')
    Question.create!(review_id: 1,
                      content: "Anything else you would like to add?",
                      answer_type: 'Text Response')
    Question.create!(review_id: 2,
                      content: "How would you rate your overall taxi experience (5 being the highest)?",
                      answer_type: '1-5')
    Question.create!(review_id: 2,
                      content: "How would you rate your driver (5 being the highest)?",
                      answer_type: '1-5')
    Question.create!(review_id: 2,
                      content: "Did you make it to your destination on time?",
                      answer_type: 'Yes/No')
    Question.create!(review_id: 2,
                      content: "Would you ride with us again?",
                      answer_type: 'Yes/No')
    Question.create!(review_id: 2,
                      content: "Anything else you would like to add?",
                      answer_type: 'Text Response')
  end

  desc 'add 2000 answers to different taxis and questions'
  task populate: :environment do
    list = User.first.taxis.all.collect(&:id)
    1000.times do |n|
      question_id = Random.rand(1..5)
      if question_id == 1 || question_id == 2 || question_id == 6 || question_id == 7
        content = Random.rand(1..5)
      elsif question_id == 3 || question_id == 4 || question_id == 9 || question_id == 8
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
    list = User.last.taxis.all.collect(&:id)
    1000.times do |n|
      question_id = Random.rand(6..10)
      if question_id == 1 || question_id == 2 || question_id == 6 || question_id == 7
        content = Random.rand(1..5)
      elsif question_id == 3 || question_id == 4 || question_id == 9 || question_id == 8
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
