module EmpresasHelper

  def empresa_actual
    @empresa ||= Empresa.first
  end

end
