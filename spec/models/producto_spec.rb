require 'rails_helper'

RSpec.describe Producto, type: :model do
  it { should belong_to :usuario }
  it { should have_many :vendidos }
  it { should have_many(:ventas).through :vendidos }

  it { should validate_presence_of :nombre }
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :existencia }
  it { should validate_presence_of :precio_venta }
  it { should validate_presence_of :usuario }
  it { should validate_presence_of :type }

  it { should_not allow_value(0).for(:precio_venta) }

  it { should validate_uniqueness_of(:codigo).case_insensitive }

  describe ".buscar" do
    let!(:armazones) { create_list :armazon, 2, tipo: "sobrepuesto" }
    let!(:armazon) do
      create :armazon, nombre: "uno", codigo: "uno", tipo: "completo",
        existencia: 40
    end

    let!(:lentes) { create_list :lente, 2, tipo: "polarizado" }
    let!(:lente) do
      create :lente, nombre: "dos", codigo: "dos", tipo: "filtro uv",
        existencia: 50
    end

    let!(:micas) { create_list :mica, 2, tipo: "monofocal" }
    let!(:mica) do
      create :mica, nombre: "tres", codigo: "tres", tipo: "cr",
        existencia: 60
    end

    context "Armazon" do
      it "regresa 1 por type" do
        expect(Producto.buscar("Armazon").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Producto.buscar("uno").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Producto.buscar("uno").count).to eq 1
      end

      it "regresa 1 por tipo" do
        expect(Producto.buscar("completo").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Producto.buscar("40").count).to eq 1
      end
    end # context Armazon

    context "Lente" do
      it "regresa 1 por type" do
        expect(Producto.buscar("Lente").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Producto.buscar("dos").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Producto.buscar("dos").count).to eq 1
      end

      it "regresa 1 por tipo" do
        expect(Producto.buscar("filtro uv").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Producto.buscar("50").count).to eq 1
      end
    end # context Lente

    context "Mica" do
      it "regresa 1 por type" do
        expect(Producto.buscar("Mica").count).to eq 3
      end

      it "regresa 1 por nombre" do
        expect(Producto.buscar("tres").count).to eq 1
      end

      it "regresa 1 por código" do
        expect(Producto.buscar("tres").count).to eq 1
      end

      it "regresa 1 por tipo" do
        expect(Producto.buscar("cr").count).to eq 1
      end

      it "regresa 1 por existencia" do
        expect(Producto.buscar("60").count).to eq 1
      end
    end # context Mica
  end # describe ".buscar"
end
