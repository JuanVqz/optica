class Cliente < ApplicationRecord
  include Domiciliable

  has_many :ventas

  validates :nombre, presence: true
  validates :nombre, uniqueness: { case_sensitive: false }

  def self.buscar texto
    where("concat_ws(' ', nombre, telefono, rfc) ILIKE ?", "%#{texto&.squish}%")
  end

  def to_s
    nombre
  end
end
