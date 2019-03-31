class VentaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def deuda?
    true unless registro.saldada?
  end

end
