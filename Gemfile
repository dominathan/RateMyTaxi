source 'https://rubygems.org'

ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

gem 'pg', '0.17.1'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '3.0.4'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '0.3.20', require: false
end

#----NEW--------
gem 'figaro', '0.7.0'
gem 'will_paginate' #added to have clickiable page numbers at bottom of page
gem 'will_paginate-bootstrap'

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem 'railroady'
  gem 'pry'
  gem 'jazz_hands'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'  #added for testing
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

#for styling
gem 'bootstrap-sass', '3.1.1'
#gem 'bootstrap3-datetimepicker-rails','~> 3.1.3'
#gem 'momentjs-rails', '>=2.8.1'
gem 'sprockets', '2.11.0'
gem 'therubyracer', '0.12.1'

#user security
gem 'devise', '3.3.0'

#nested_fields for reviews/questions
gem 'cocoon', '1.2.6'

gem 'highcharts-rails', '~> 4.0.1' #for highcharts.js
gem 'faker' #for fake dummy data
gem 'jquery-datatables-rails' #beautiful tables
gem 'rqrcode-with-patches', '~> 0.5.4' #for QR codes
gem 'jquery-raty-rails', github: 'bmc/jquery-raty-rails' #for star power!
