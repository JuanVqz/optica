require 'rails_helper'

RSpec.describe Empresa, type: :model do
  it { should validate_presence_of :nombre }
  it { should validate_presence_of :logotipo }

  it { should have_one(:domicilio).dependent(:destroy) }
  it { should accept_nested_attributes_for(:domicilio).allow_destroy(true) }

  describe "#to_s" do
    let(:empresa) { create :empresa }

    it "debe regresar el nombre de la empresa" do
      expect(empresa.to_s).to eq empresa.nombre
    end
  end # describe "#to_s"
end
