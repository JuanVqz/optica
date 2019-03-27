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

  describe "#existencia_de_productos" do
    let(:marca) { create :marca }

    context "cuando la marca tiene productos" do
      let(:lente) { create :lente, existencia: 2, marca_id: marca.id }
      let(:armazon) { create :armazon, existencia: 2, marca_id: marca.id }

      it "debe regresar 4" do
        [lente, armazon]
        expect(marca.existencia_de_productos).to eq 4
      end
    end # context cuando la marca tiene productos

    context "cuando la marca no tiene productos" do
      it "debe regresar 0" do
        expect(marca.existencia_de_productos).to eq 0
      end
    end # context cuando la marca no tiene productos
  end # describe "#existencia_de_productos"

  describe "#to_s" do
    let(:marca) { create :marca, nombre: 'la marca' }

    it "debe regresar el nombre de la marca" do
      expect(marca.to_s).to eq 'la marca'
    end
  end # describe "#to_s"
end
