module ApplicationHelper

  def codigo_de_barras modelo
    CodigoDeBarrasServicio.new(modelo).convertir
  end

end
