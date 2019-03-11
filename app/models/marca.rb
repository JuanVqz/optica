class Marca < ApplicationRecord
  validates :nombre, presence: true
  validates :nombre, uniqueness: { case_sensitive: false }

  def self.buscar texto
    where("concat_ws(' ', nombre, descripcion) ILIKE ?", "%#{texto&.squish}%")
  end

  def to_s
    nombre
  end
end
