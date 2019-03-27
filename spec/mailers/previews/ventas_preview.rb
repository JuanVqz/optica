# Preview all emails at http://localhost:3000/rails/mailers/ventas
class VentasPreview < ActionMailer::Preview

  def nueva
    venta = Venta.first
    VentasMailer.nueva(venta).deliver
  end

end
