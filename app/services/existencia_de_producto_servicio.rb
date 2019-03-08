class ExistenciaDeProductoServicio
  attr_accessor :vendidos

  def initialize(venta)
    @vendidos = venta.vendidos
  end

  def descontar
    vendidos.each do |v|
      v.producto.existencia -= v.cantidad
      v.producto.save
    end
  end

end
