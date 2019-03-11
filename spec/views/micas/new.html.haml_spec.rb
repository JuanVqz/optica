require 'rails_helper'

RSpec.describe "micas/new", type: :view do
  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    assign(:mica, Mica.new(
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

    it "muestra precio_compra en el formulario" do
      render

      assert_select "form[action=?][method=?]", micas_path, "post" do
        assert_select "input[name=?]", "mica[nombre]"
        assert_select "input[name=?]", "mica[codigo]"
        assert_select "select[name=?]", "mica[marca_id]"
        assert_select "textarea[name=?]", "mica[descripcion]"
        assert_select "input[name=?]", "mica[precio_venta]"
        assert_select "input[name=?]", "mica[precio_compra]"
        assert_select "input[name=?]", "mica[existencia]"
        assert_select "select[name=?]", "mica[tipo]"
      end
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no muestra precio_compra en el formulario" do
      render

      assert_select "form[action=?][method=?]", micas_path, "post" do
        assert_select "input[name=?]", "mica[nombre]"
        assert_select "input[name=?]", "mica[codigo]"
        assert_select "select[name=?]", "mica[marca_id]"
        assert_select "textarea[name=?]", "mica[descripcion]"
        assert_select "input[name=?]", "mica[precio_venta]"
        assert_select "input[name=?]", "mica[existencia]"
        assert_select "select[name=?]", "mica[tipo]"
      end
    end
  end # context cuando es vendedor
end
