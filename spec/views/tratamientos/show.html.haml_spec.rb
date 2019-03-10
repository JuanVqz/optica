require 'rails_helper'

RSpec.describe "tratamientos/show", type: :view do

  let(:vendedor) { create :vendedor }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    @tratamiento = assign(:tratamiento, Tratamiento.create!(
      nombre: "tratamiento 2",
      codigo: "TR2",
      descripcion: "descripción del tratamiento 2",
      precio_venta: 100,
      precio_compra: 0,
      existencia: 10,
      tipo: nil,
      usuario: vendedor
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

end
