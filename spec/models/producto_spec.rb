require 'rails_helper'

RSpec.describe Producto, type: :model do
  it { should belong_to :marca }
  it { should belong_to :usuario }
  it { should have_many :vendidos }
  it { should have_many(:ventas).through :vendidos }

  it { should validate_presence_of :nombre }
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :existencia }
  it { should validate_presence_of :precio_venta }
  it { should validate_presence_of :usuario }
  it { should validate_presence_of :type }
  it { should validate_presence_of :marca_id }

  it { should_not allow_value(0).for(:precio_venta) }

  it { should validate_uniqueness_of(:codigo).case_insensitive }

  describe ".buscar" do
    let!(:armazones) { create_list :armazon, 2, tipo: "sobrepuesto" }
    let!(:armazon) do
      create :armazon, nombre: "uno", codigo: "uno", tipo: "completo",
        existencia: 60
    end

    let!(:lentes) { create_list :lente, 2, tipo: "polarizado" }
    let!(:lente) do
      create :lente, nombre: "dos", codigo: "dos", tipo: "filtro uv",
        existencia: 70
    end

    let!(:micas) { create_list :mica, 2, tipo: "monofocal" }
    let!(:mica) do
      create :mica, nombre: "tres", codigo: "tres", tipo: "cr",
        existencia: 80
    end

    let!(:tratamientas) { create_list :tratamiento, 2 }
    let!(:tratamiento) do
      create :tratamiento, nombre: "cuatro", codigo: "cuatro",
        existencia: 90
    end

    context "Armazon" do
      it "regresa 3 por type" do
        expect(Armazon.buscar("Armazon").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Armazon.buscar("uno").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Armazon.buscar("uno").count).to eq 1
      end

      it "regresa 1 por tipo" do
        expect(Armazon.buscar("completo").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Armazon.buscar("60").count).to eq 1
      end
    end # context Armazon

    context "Lente" do
      it "regresa 3 por type" do
        expect(Lente.buscar("Lente").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Lente.buscar("dos").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Lente.buscar("dos").count).to eq 1
      end

      it "regresa 1 por tipo" do
        expect(Lente.buscar("filtro uv").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Lente.buscar("70").count).to eq 1
      end
    end # context Lente

    context "Mica" do
      it "regresa 3 por type" do
        expect(Mica.buscar("Mica").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Mica.buscar("tres").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Mica.buscar("tres").count).to eq 1
      end

      it "regresa 1 por tipo" do
        expect(Mica.buscar("cr").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Mica.buscar("80").count).to eq 1
      end
    end # context Mica

    context "Tratamiento" do
      it "regresa 3 por type" do
        expect(Tratamiento.buscar("Tratamiento").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Tratamiento.buscar("cuatro").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Tratamiento.buscar("cuatro").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Tratamiento.buscar("90").count).to eq 1
      end
    end # context Tratamiento
  end # describe ".buscar"
end
