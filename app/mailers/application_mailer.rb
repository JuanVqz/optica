class ApplicationMailer < ActionMailer::Base
  default from: ENV['OPTICA_EMAIL']
  helper :tiendas
  layout 'mailer'
end
