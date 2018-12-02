# Load the Rails application.
require_relative 'application'
ActionMailer::Base.smtp_settings = {
  :user_name => 'app117624749@heroku.com',
  :password => '0b0eq9n12062',
  :domain => 'enjoystudyingapp.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
# Initialize the Rails application.
Rails.application.initialize!
