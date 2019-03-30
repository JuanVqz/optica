class NotificarVentaNuevaWorker
  include Sidekiq::Worker

  def perform(id)
    venta = Venta.find(id)
    VentasMailer.nueva(venta).deliver
  end
end
