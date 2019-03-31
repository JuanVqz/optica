class SuperUsuario < Usuario
  before_create :establecer_cargo

  private

  def establecer_cargo
    self.cargo = 'superusuario'
  end
end
