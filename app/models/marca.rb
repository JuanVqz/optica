class Marca < ApplicationRecord
  validates :nombre, presence: true
  validates :nombre, uniqueness: { case_sensitive: false }

  has_many :productos

  def self.buscar texto
    where("concat_ws(' ', nombre, descripcion) ILIKE ?", "%#{texto&.squish}%")
  end

  def to_s
    nombre
  end
end
