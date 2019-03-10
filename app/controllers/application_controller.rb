class ApplicationController < ActionController::Base
  before_action :authenticate_usuario!
  layout :establecer_plantilla

  include Pundit
  protect_from_forgery

  private

  def establecer_plantilla
    return 'devise' if devise_controller?
    'application'
  end
end
