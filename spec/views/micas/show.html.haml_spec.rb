require 'rails_helper'

RSpec.describe "micas/show", type: :view do

  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    @mica = assign(:mica, Mica.create!(
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

  context "cuando es administrador" do
    let(:usuario) { create :administrador }

    it "muestra precio_compra y los atributos" do
      render

      expect(rendered).to match(/0/)
      expect(rendered).to match(/mica 2/)
      expect(rendered).to match(/MC2/)
      expect(rendered).to match(/monofocal/)
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no muestra precio_compra" do
      render

      expect(rendered).to match(/mica 2/)
      expect(rendered).to match(/MC2/)
      expect(rendered).to match(/monofocal/)
    end
  end # context cuando es vendedor

end
