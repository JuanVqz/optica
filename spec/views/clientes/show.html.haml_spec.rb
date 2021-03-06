require 'rails_helper'

RSpec.describe "clientes/show", type: :view do

  let(:corporacion) { create :corporacion }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    @cliente = assign(:cliente, Cliente.create!(
      nombre: "Nombre",
      rfc: "Rfc",
      telefono: "telefono",
      corporacion_id: corporacion.id
    ))
  end

  context "cuando es administrador" do
    let(:usuario) { create :administrador }

    it "debe mostrar el boton editar" do
      render

      expect(rendered).to match(/editar/)

      expect(rendered).to match(/Nombre/)
      expect(rendered).to match(/Rfc/)
      expect(rendered).to match(/telefono/)
      expect(rendered).to match(corporacion.nombre)
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no debe mostrar el boton editar" do
      render

      expect(rendered).not_to match(/editar/)

      expect(rendered).to match(/Nombre/)
      expect(rendered).to match(/Rfc/)
      expect(rendered).to match(/telefono/)
      expect(rendered).to match(corporacion.nombre)
    end
  end # context cuando es vendedor

end
