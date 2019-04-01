class ExistenciaDeProductoServicio
  attr_accessor :venta

  def initialize(venta)
    @venta = venta
  end

  def descontar
    if venta.saldada?
      descontar_existencia
      VentasMailer.descontar_productos(venta).deliver
    end
  end

  def descontar_existencia
    venta.vendidos.each do |v|
      v.producto.existencia -= v.cantidad
      v.producto.save
    end
  end
end
