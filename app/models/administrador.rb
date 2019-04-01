class Administrador < Usuario
  before_create :establecer_cargo

  scope :notificar, -> { where(notificar: true) }

  private

  def establecer_cargo
    self.cargo = 'admin'
  end
end
