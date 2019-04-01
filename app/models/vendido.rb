class Vendido < ApplicationRecord
  belongs_to :venta
  belongs_to :producto

  validates :cantidad, :precio_venta, :precio_compra,
    :descuento, :subtotal, presence: true

  validates :cantidad, :precio_venta, :subtotal,
    numericality: { greater_than: 0 }
  validates :precio_compra, numericality: { greater_than_or_equal_to: 0 }

  delegate :nombre, :codigo, :tipo, :marca, to: :producto, prefix: false,
    allow_nil: true

  default_scope { includes(:producto) }

  def to_s
    codigo
  end
end
