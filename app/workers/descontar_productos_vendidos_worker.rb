class DescontarProductosVendidosWorker
  include Sidekiq::Worker

  def perform(id)
    venta = Venta.find(id)
    ExistenciaDeProductoServicio.new(venta).descontar
  end
end
