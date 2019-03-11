module MarcasHelper

  def opciones_de_marcas
    Marca.all.map { |m| [m, m.id] }
  end

end
