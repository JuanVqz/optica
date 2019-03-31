require 'rails_helper'

RSpec.describe ClientePolicy, type: :policy do

  let(:superusuario) { create :super_usuario }
  let(:admin) { create :administrador }
  let(:vendedor) { create :vendedor }

  let(:registro) { create :cliente }

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

  permissions :new?, :create?, :show? do
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

  permissions :edit?, :update? do
    it "no debe acceder cuando es vendedor" do
      expect(subject).not_to permit(vendedor, registro)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, registro)
    end

    it "debe acceder cuando es superusuario" do
      expect(subject).to permit(superusuario, registro)
    end
  end

end
