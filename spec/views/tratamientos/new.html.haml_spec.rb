require 'rails_helper'

RSpec.describe "tratamientos/new", type: :view do
  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    assign(:tratamiento, Tratamiento.new(
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

    it "muestra precio_compra en el formulario" do
      render

      assert_select "form[action=?][method=?]", tratamientos_path, "post" do
        assert_select "input[name=?]", "tratamiento[nombre]"
        assert_select "input[name=?]", "tratamiento[codigo]"
        assert_select "select[name=?]", "tratamiento[marca_id]"
        assert_select "textarea[name=?]", "tratamiento[descripcion]"
        assert_select "input[name=?]", "tratamiento[precio_venta]"
        assert_select "input[name=?]", "tratamiento[precio_compra]"
        assert_select "input[name=?]", "tratamiento[existencia]"
      end
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no muestra precio_compra en el formulario" do
      render

      assert_select "form[action=?][method=?]", tratamientos_path, "post" do
        assert_select "input[name=?]", "tratamiento[nombre]"
        assert_select "input[name=?]", "tratamiento[codigo]"
        assert_select "select[name=?]", "tratamiento[marca_id]"
        assert_select "textarea[name=?]", "tratamiento[descripcion]"
        assert_select "input[name=?]", "tratamiento[precio_venta]"
        assert_select "input[name=?]", "tratamiento[existencia]"
      end
    end
  end # context cuando es vendedor
end
