class ClientePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    create?
  end

  def show?
    create?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def create?
    true
  end

  def update?
    true unless usuario.vendedor?
  end

end
