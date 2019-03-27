class Marca < ApplicationRecord
  validates :nombre, presence: true
  validates :nombre, uniqueness: { case_sensitive: false }

  has_many :productos

  scope :con_productos, -> { includes(:productos) }

  def self.buscar texto
    where("concat_ws(' ', nombre, descripcion) ILIKE ?", "%#{texto&.squish}%")
  end

  def existencia_de_productos
    productos.map(&:existencia).sum
  end

  def to_s
    nombre
  end
end
