require 'rails_helper'

RSpec.describe EmpresaPolicy, type: :policy do

  let(:vendedor) { create :vendedor }
  let(:admin) { create :administrador }
  let(:empresa) { create :empresa }

  subject { described_class }

  permissions :index? do
    it "no debe acceder cuando es vendedor" do
      expect(subject).not_to permit(vendedor, empresa)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, empresa)
    end
  end

  permissions :new?, :create? do
    it "no debe acceder cuando es vendedor" do
      expect(subject).not_to permit(vendedor, empresa)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, empresa)
    end
  end

  permissions :show?, :edit?, :update?, :destroy? do
    it "no debe acceder cuando es vendedor" do
      expect(subject).not_to permit(vendedor, empresa)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, empresa)
    end
  end

end
