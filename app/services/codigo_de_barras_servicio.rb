require 'barby/barcode/ean_13'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

class CodigoDeBarrasServicio

  attr_accessor :modelo

  def initialize modelo
    @modelo = modelo
  end

  def convertir
    codigo = es_venta? ? codigo_de_venta : codigo_de_producto
    formato_svg codigo
  end

  private

  def es_venta?
    modelo.is_a?Venta
  end

  def codigo_de_producto
    Barby::Code128B.new(modelo.codigo)
  end

  def codigo_de_venta
    Barby::EAN13.new(eliminar_checksum!)
  end

  def eliminar_checksum!
    modelo.codigo.chop!
  end

  def formato_svg codigo
    escapar_html codigo.to_svg
  end

  def escapar_html codigo
    codigo.html_safe
  end

end
