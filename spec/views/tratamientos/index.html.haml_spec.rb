require 'rails_helper'

RSpec.describe "tratamientos/index", type: :view do
  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    assign(:tratamientos, Kaminari.paginate_array([
      Tratamiento.create!(
        nombre: "tratamiento 1",
        codigo: "TR1",
        descripcion: "descripción del tratamiento 1",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: nil,
        usuario: vendedor,
        marca: marca
      ),
      Tratamiento.create!(
        nombre: "tratamiento 2",
        codigo: "TR2",
        descripcion: "descripción del tratamiento 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: nil,
        usuario: vendedor,
        marca: marca
      ),
    ]).page(1))
  end

  it "muestra la lista de tratamientos" do
    render
    assert_select "tr>td", text: "10".to_s, count: 2
    assert_select "tr>td", text: "TR2".to_s, count: 1
  end
end
