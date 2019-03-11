require 'rails_helper'

RSpec.describe "armazones/show", type: :view do

  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    @armazon = assign(:armazon, Armazon.create!(
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

  context "cuando es administrador" do
    let(:usuario) { create :administrador }

    it "muestra precio_compra y los atributos" do
      render

      expect(rendered).to match(/0/)
      expect(rendered).to match(/armazon 2/)
      expect(rendered).to match(/AZ2/)
      expect(rendered).to match(/sobrepuesto/)
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no muestra precio_compra" do
      render

      expect(rendered).to match(/armazon 2/)
      expect(rendered).to match(/AZ2/)
      expect(rendered).to match(/sobrepuesto/)
    end
  end # context cuando es vendedor

end
