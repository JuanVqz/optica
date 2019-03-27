class Producto < ApplicationRecord
  mount_uploaders :imagenes, ImagenUploader

  belongs_to :marca
  belongs_to :usuario
  has_many :vendidos
  has_many :ventas, through: :vendidos

  validates :nombre, :codigo, :existencia, :precio_venta,
    :usuario, :type, :marca_id, presence: true
  validates :precio_venta, numericality: { greater_than: 0 }
  validates :codigo, uniqueness: { case_sensitive: false }

  scope :con_marca, -> { includes(:marca) }

  def self.buscar texto
    where("concat_ws(' ', codigo, nombre, tipo, type) ILIKE ?", "%#{texto&.squish}%")
  end

  def to_s
    "#{codigo} #{nombre}"
  end
end
