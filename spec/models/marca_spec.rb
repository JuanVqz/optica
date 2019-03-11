require 'rails_helper'

RSpec.describe Marca, type: :model do
  it { should validate_presence_of :nombre }
  it { should validate_uniqueness_of(:nombre).case_insensitive }

  it { should have_many :productos }

  describe ".buscar" do
    let!(:marcas) { create_list :marca, 4 }
    let!(:marca) { create :marca, nombre: 'OAKLEY', descripcion: 'zzz' }

    it "regresa 1 coincidencia por nombre" do
      expect(Marca.buscar('oakley').count).to eq 1
    end

    it "regresa 1 coincidencia por descripción" do
      expect(Marca.buscar('ZZZ').count).to eq 1
    end
  end # describe ".buscar"

  describe "#to_s" do
    let(:marca) { create :marca, nombre: 'la marca' }

    it "debe regresar el nombre de la marca" do
      expect(marca.to_s).to eq 'la marca'
    end
  end # describe "#to_s"
end
