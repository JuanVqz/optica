class Administrador < Usuario
  before_create :establecer_cargo

  private

  def establecer_cargo
    self.cargo = 'admin'
  end
end
