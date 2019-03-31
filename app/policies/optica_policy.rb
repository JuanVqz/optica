class OpticaPolicy < Struct.new(:usuario, :optica)

  def admin?
    true unless usuario.vendedor?
  end

end
