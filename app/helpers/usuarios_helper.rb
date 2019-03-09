module UsuariosHelper

  def permitir_notificar modelo
    content_tag :span, class: "badge #{badge_notificar(modelo)}" do
      modelo.notificar? ? 'SI PERMITIR' : 'NO PERMITIR'
    end
  end

  private

  def badge_notificar modelo
    modelo.notificar? ? 'badge-primary' : 'badge-danger'
  end
end
