class ApplicationController < ActionController::Base
  before_action :authenticate_usuario!
  layout :establecer_plantilla

  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :usuario_no_autorizado

  def current_user
    current_usuario
  end

  protected

  def configuracion_pdf(modelo)
    {
      pdf: nombre_pdf,
      template: "pdfs/#{modelo.pluralize}/#{modelo}",
      margin: { top: '50', bottom: '10' },
      header: { html: { template: 'pdfs/cabeza' } },
      footer: { html: { template: 'pdfs/pie' } }
    }
  end

  private

  def usuario_no_autorizado exception
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit",
                      default: :default
    redirect_to(request.referrer || root_path)
  end

  def establecer_plantilla
    return 'devise' if devise_controller?
    'application'
  end
end
