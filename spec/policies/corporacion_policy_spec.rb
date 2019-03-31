require 'rails_helper'

RSpec.describe CorporacionPolicy, type: :policy do

  let(:superusuario) { create :super_usuario }
  let(:admin) { create :administrador }
  let(:vendedor) { create :vendedor }

  let(:registro) { create :corporacion }

  subject { described_class }

  permissions :index? do
    it "debe acceder cuando es vendedor" do
      expect(subject).to permit(vendedor, registro)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, registro)
    end

    it "debe acceder cuando es superusuario" do
      expect(subject).to permit(superusuario, registro)
    end
  end

  permissions :new?, :create? do
    it "debe acceder cuando es vendedor" do
      expect(subject).to permit(vendedor, registro)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, registro)
    end

    it "debe acceder cuando es superusuario" do
      expect(subject).to permit(superusuario, registro)
    end
  end

  permissions :show?, :edit?, :update?, :destroy? do
    it "debe acceder cuando es vendedor" do
      expect(subject).to permit(vendedor, registro)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, registro)
    end

    it "debe acceder cuando es superusuario" do
      expect(subject).to permit(superusuario, registro)
    end
  end

end
