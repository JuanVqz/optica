require 'rails_helper'

RSpec.describe OpticaPolicy, type: :policy do

  let(:admin) { create :administrador }
  let(:vendedor) { create :vendedor }

  subject { described_class }

  permissions :admin? do
    it "no debe acceder cuando es vendedor" do
      expect(subject).not_to permit(vendedor, :admin)
    end

    it "debe acceder cuando es administrador" do
      expect(subject).to permit(admin, :admin)
    end
  end

end
