class EmpresaPolicy < ApplicationPolicy

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
    create?
  end

  def create?
    user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

end
