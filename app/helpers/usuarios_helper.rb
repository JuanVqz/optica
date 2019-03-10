module UsuariosHelper

  def permitir_notificar modelo
    content_tag :span, class: "badge #{badge_notificar(modelo)}" do
      modelo.notificar? ? 'SI PERMITIR' : 'NO PERMITIR'
    end
  end

  def puede?(accion, recurso)
    Pundit.policy(current_usuario, recurso).try "#{accion}?"
  end
  alias_method :usuario_es?, :puede?

  private

  def badge_notificar modelo
    modelo.notificar? ? 'badge-primary' : 'badge-danger'
  end
end
