require 'rails_helper'

RSpec.describe "armazones/edit", type: :view do
  let(:vendedor) { create :vendedor }

  before(:each) do
    @armazon = assign(:armazon, Armazon.create!(
      nombre: "armazon 2",
      codigo: "AZ2",
      descripcion: "descripción del armazones 2",
      precio_venta: 100,
      precio_compra: 0,
      existencia: 10,
      tipo: "sobrepuesto",
      usuario: vendedor
    ))
  end

  it "muestra el formulario de editar armazon" do
    render

    assert_select "form[action=?][method=?]", armazon_path(@armazon), "post" do

      assert_select "input[name=?]", "armazon[nombre]"

      assert_select "input[name=?]", "armazon[codigo]"

      assert_select "textarea[name=?]", "armazon[descripcion]"

      assert_select "input[name=?]", "armazon[precio_venta]"

      assert_select "input[name=?]", "armazon[precio_compra]"

      assert_select "input[name=?]", "armazon[existencia]"

      assert_select "select[name=?]", "armazon[tipo]"
    end
  end
end