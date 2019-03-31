class Usuario < ApplicationRecord
  enum cargo: [:vendedor, :admin, :superusuario]

  has_many :armazones
  has_many :lentes
  has_many :micas
  has_many :tratamientos
  has_many :ventas

  validates :nombre, presence: true
  validates :nombre, uniqueness: { case_sensitive: false }

  def active_for_authentication?
    super && activo?
  end

  def inactive_message
    activo? ? super : :account_inactive
  end

  def to_s
    nombre.titleize
  end

  devise :database_authenticatable, :recoverable, :rememberable,
    :validatable, :trackable
end
