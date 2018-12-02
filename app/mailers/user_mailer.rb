require 'sendgrid-ruby'
include SendGrid
class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer'
  sg = SendGrid::API.new(api_key: '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')
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers # to make sure that your mailer uses the devise views
end
