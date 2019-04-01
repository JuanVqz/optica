class VentasMailer < ApplicationMailer

  def nueva(venta)
    @venta = venta

    administradores.each do |admin|
      @admin = admin
      mail(to: @admin.email, subject: "#{@admin}, se realizó una nueva venta")
    end
  end

  def descontar_productos(venta)
    @venta = venta

    administradores.each do |admin|
      @admin = admin
      mail(to: @admin.email, subject: "#{@admin}, se descontó producto del inventario")
    end
  end

  private

  def administradores
    @administradores ||= Administrador.where(notificar: true)
  end
end
