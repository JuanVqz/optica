class ApplicationMailer < ActionMailer::Base
  default from: ENV['OPTICA_EMAIL'] || "notificaciones@optica.com"
  helper :tiendas
  layout 'mailer'
end
