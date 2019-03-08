class Venta < ApplicationRecord
  PRIMER_CODIGO = "1000000000016"

  before_save :comprobar_estado_de_pago
  before_create :asignar_siguiente_codigo
  after_save :descontar_existencia_de_producto!

  belongs_to :cliente
  belongs_to :usuario
  has_many :vendidos, dependent: :destroy
  has_many :productos, through: :vendidos
  has_many :pagos, dependent: :destroy

  accepts_nested_attributes_for :vendidos
  accepts_nested_attributes_for :pagos

  validates :cliente, :fecha_entrega, presence: true
  validates :total, numericality: { greater_than: 0 }

  scope :recientes_primero, -> { Venta.order(created_at: :desc) }

  def suma_precios_venta
    vendidos.map { |v| v.precio_venta * v.cantidad }.sum
  end

  def suma_descuentos
    vendidos.map(&:descuento).sum
  end

  def deuda
    total - suma_anticipos
  end

  def suma_anticipos
    self.pagos.map(&:anticipo).reduce(0,:+)
  end

  def to_s
    codigo
  end

  private

  def comprobar_estado_de_pago
    self.saldada = anticipos_mayor_o_igual_que_total?
  end

  def anticipos_mayor_o_igual_que_total?
    suma_anticipos >= self.total
  end

  def asignar_siguiente_codigo
    Codigo::Siguiente.new(self).asignar
  end

  def descontar_existencia_de_producto!
    ExistenciaDeProductoServicio.new(self).descontar if saldada?
  end

end
