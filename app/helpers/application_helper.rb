module ApplicationHelper

  def codigo_de_barras modelo
    CodigoDeBarrasServicio.new(modelo).convertir
  end

  def ruta_actual ruta
    'active' if request.path.include? ruta
  end

end
