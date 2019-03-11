require 'rails_helper'

RSpec.describe Marca, type: :model do
  it { should validate_presence_of :nombre }
  it { should validate_uniqueness_of(:nombre).case_insensitive }

  describe "#to_s" do
    let(:marca) { create :marca, nombre: 'la marca' }

    it "debe regresar el nombre de la marca" do
      expect(marca.to_s).to eq 'la marca'
    end
  end # describe "#to_s"
end
