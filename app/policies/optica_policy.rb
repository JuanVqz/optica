class OpticaPolicy < Struct.new(:usuario, :optica)

  def admin?
    usuario.admin?
  end

end
