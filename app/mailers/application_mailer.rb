class ApplicationMailer < ActionMailer::Base
  default from: ENV['OPTICA_EMAIL']
  layout 'mailer'
end
