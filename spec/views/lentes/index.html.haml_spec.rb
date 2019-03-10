require 'rails_helper'

RSpec.describe "lentes/index", type: :view do
  let(:vendedor) { create :vendedor }

  before(:each) do
    assign(:lentes, Kaminari.paginate_array([
      Lente.create!(
        nombre: "lente 1",
        codigo: "LN1",
        descripcion: "descripción del lente 1",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "filtro uv",
        usuario: vendedor
      ),
      Armazon.create!(
        nombre: "lente 2",
        codigo: "LN2",
        descripcion: "descripción del lente 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "polarizado",
        usuario: vendedor
      ),
    ]).page(1))
  end

  it "muestra la lista de lentes" do
    render
    assert_select "tr>td", text: "10".to_s, count: 2
    assert_select "tr>td", text: "polarizado".to_s, count: 1
  end
end
