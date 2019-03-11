require 'rails_helper'

RSpec.describe "armazones/new", type: :view do
  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    assign(:armazon, Armazon.new(
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

    it "muestra precio_compra en el formulario" do
      render

      assert_select "form[action=?][method=?]", armazones_path, "post" do
        assert_select "input[name=?]", "armazon[nombre]"
        assert_select "input[name=?]", "armazon[codigo]"
        assert_select "select[name=?]", "armazon[marca_id]"
        assert_select "textarea[name=?]", "armazon[descripcion]"
        assert_select "input[name=?]", "armazon[precio_venta]"
        assert_select "input[name=?]", "armazon[precio_compra]"
        assert_select "input[name=?]", "armazon[existencia]"
        assert_select "select[name=?]", "armazon[tipo]"
      end
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no muestra precio_compra en el formulario" do
      render

      assert_select "form[action=?][method=?]", armazones_path, "post" do
        assert_select "input[name=?]", "armazon[nombre]"
        assert_select "input[name=?]", "armazon[codigo]"
        assert_select "select[name=?]", "armazon[marca_id]"
        assert_select "textarea[name=?]", "armazon[descripcion]"
        assert_select "input[name=?]", "armazon[precio_venta]"
        assert_select "input[name=?]", "armazon[existencia]"
        assert_select "select[name=?]", "armazon[tipo]"
      end
    end
  end # context cuando es vendedor
end
