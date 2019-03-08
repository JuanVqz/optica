require 'barby/barcode/ean_13'

class CodigoSiguienteServicio

  attr_accessor :modelo
  LARGO_DE_CODIGO = 12

  def initialize modelo
    @modelo = modelo
  end

  def asignar
    return primer_codigo if es_primer_registro?
    modelo.codigo = siguiente_codigo
  end

  def es_primer_registro?
    modelo.class.count < 1
  end

  def primer_codigo
    modelo.codigo = modelo.class::PRIMER_CODIGO
  end

  def siguiente_codigo
    eliminar_checksum! modelo.class.last.codigo
  end

  def eliminar_checksum! codigo
    sumar_uno codigo.chop!
  end

  def sumar_uno codigo
    largo_valido codigo.to_i + 1
  end

  def largo_valido codigo
    codigo = codigo.to_s.rjust(LARGO_DE_CODIGO, '0')
    formato_ean_13 codigo
  end

  def formato_ean_13 codigo
    Barby::EAN13.new(codigo).to_s
  end
end
