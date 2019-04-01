# Preview all emails at http://localhost:3000/rails/mailers/ventas
class VentasPreview < ActionMailer::Preview

  def nueva
    venta = Venta.first
    VentasMailer.nueva(venta).deliver
  end

  def descontar_productos
    venta = Venta.first
    VentasMailer.descontar_productos(venta).deliver
  end

end
