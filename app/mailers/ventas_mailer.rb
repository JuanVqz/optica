class VentasMailer < ApplicationMailer

  def nueva(venta)
    @venta = venta

    administradores = Administrador.where(notificar: true)
    administradores.each do |admin|
      @admin = admin
      mail(to: @admin.email, subject: "#{@admin}, se realizó una nueva venta")
    end
  end

end
