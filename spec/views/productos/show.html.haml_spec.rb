require 'rails_helper'

RSpec.describe "productos/show", type: :view do

  before :each do
    allow(view).to receive(:current_usuario).and_return(usuario)
  end

  context "cuando el producto es armazon" do
    let(:vendedor) { create :vendedor }
    let(:marca) { create :marca }

    before(:each) do
      @producto = assign(:armazon, Armazon.create!(
        nombre: "armazon 2",
        codigo: "AZ2",
        descripcion: "descripción del armazones 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "sobrepuesto",
        usuario: vendedor,
        marca: marca
      ))
    end

    context "administrador" do
      let(:usuario) { create :administrador }

      it "muestra precio_compra y los atributos" do
        render
        expect(rendered).to match(/0/)
        expect(rendered).to match(/armazon 2/)
        expect(rendered).to match(/AZ2/)
        expect(rendered).to match(/sobrepuesto/)
      end
    end # context cuando es administrador

    context "vendedor" do
      let(:usuario) { create :vendedor }

      it "no muestra precio_compra" do
        render
        expect(rendered).to match(/armazon 2/)
        expect(rendered).to match(/AZ2/)
        expect(rendered).to match(/sobrepuesto/)
      end
    end # context cuando es vendedor
  end # context cuando el producto es armazon

  context "cuando el producto es lente" do
    let(:vendedor) { create :vendedor }
    let(:marca) { create :marca }

    before(:each) do
      @producto = assign(:lente, Lente.create!(
        nombre: "lente 2",
        codigo: "LN2",
        descripcion: "descripción del lente 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "polarizado",
        usuario: vendedor,
        marca: marca
      ))
    end

    context "cuando es administrador" do
      let(:usuario) { create :administrador }

      it "muestra precio_compra y los atributos" do
        render
        expect(rendered).to match(/0/)
        expect(rendered).to match(/lente 2/)
        expect(rendered).to match(/LN2/)
        expect(rendered).to match(/polarizado/)
      end
    end

    context "cuando es vendedor" do
      let(:usuario) { create :vendedor }

      it "no muestra precio_compra" do
        render
        expect(rendered).to match(/lente 2/)
        expect(rendered).to match(/LN2/)
        expect(rendered).to match(/polarizado/)
      end
    end
  end # context cuando el producto es lente

  context "cuando el producto es mica" do
    let(:vendedor) { create :vendedor }
    let(:marca) { create :marca }

    before(:each) do
      @producto = assign(:mica, Mica.create!(
        nombre: "mica 2",
        codigo: "MC2",
        descripcion: "descripción de la mica 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "monofocal",
        usuario: vendedor,
        marca: marca
      ))
    end

    context "administrador" do
      let(:usuario) { create :administrador }

      it "muestra precio_compra y los atributos" do
        render

        expect(rendered).to match(/0/)
        expect(rendered).to match(/mica 2/)
        expect(rendered).to match(/MC2/)
        expect(rendered).to match(/monofocal/)
      end
    end # context cuando es administrador

    context "vendedor" do
      let(:usuario) { create :vendedor }

      it "no muestra precio_compra" do
        render

        expect(rendered).to match(/mica 2/)
        expect(rendered).to match(/MC2/)
        expect(rendered).to match(/monofocal/)
      end
    end # context cuando es vendedor
  end # context cuando el producto es mica

  context "cuando el producto es tratamiento" do
    let(:vendedor) { create :vendedor }
    let(:marca) { create :marca }

    before(:each) do
      @producto = assign(:tratamiento, Tratamiento.create!(
        nombre: "tratamiento 2",
        codigo: "TR2",
        descripcion: "descripción del tratamiento 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: nil,
        usuario: vendedor,
        marca: marca
      ))
    end

    context "cuando es administrador" do
      let(:usuario) { create :administrador }

      it "muestra precio_compra y los atributos" do
        render

        expect(rendered).to match(/0/)
        expect(rendered).to match(/tratamiento 2/)
        expect(rendered).to match(/TR2/)
      end
    end # context cuando es administrador

    context "cuando es vendedor" do
      let(:usuario) { create :vendedor }

      it "no muestra precio_compra" do
        render

        expect(rendered).to match(/tratamiento 2/)
        expect(rendered).to match(/TR2/)
      end
    end # context cuando es vendedor
  end # context cuando el producto es tratamiento

end
