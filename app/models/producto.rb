class Producto < ApplicationRecord
  mount_uploaders :imagenes, ImagenUploader

  belongs_to :marca
  belongs_to :usuario
  has_many :vendidos
  has_many :ventas, through: :vendidos

  validates :nombre, :codigo, :existencia, :precio_venta,
    :usuario, :type, presence: true
  validates :precio_venta, numericality: { greater_than: 0 }
  validates :codigo, uniqueness: { case_sensitive: false }

  def self.buscar texto
    where("concat_ws(' ', codigo, nombre, tipo, type, existencia) ILIKE ?", "%#{texto&.squish}%")
  end

  def to_s
    "#{codigo} #{nombre}"
  end
end
