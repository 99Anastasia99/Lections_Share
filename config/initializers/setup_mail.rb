ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              =>  'smtp.sendgrid.net',
  :port                 =>  '587',
  :authentication       =>  :plain,
  :user_name            =>  'Nastassia Shymanskaya',
  :password             =>  'Vkontakte99130998',
  :domain               =>  'heroku.com',
  :enable_starttls_auto  =>  true
}
