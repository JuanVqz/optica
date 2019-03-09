module ProductosHelper

  def estado_de_publicacion modelo
    content_tag :span, class: "badge #{badge_publicado(modelo)}" do
      modelo.publicado? ? 'PUBLICADO' : 'NO PUBLICADO'
    end
  end

  private

  def badge_publicado modelo
    modelo.publicado? ? 'badge-success' : 'badge-primary'
  end

end
