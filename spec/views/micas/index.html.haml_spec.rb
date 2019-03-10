require 'rails_helper'

RSpec.describe "micas/index", type: :view do
  let(:vendedor) { create :vendedor }

  before(:each) do
    assign(:micas, Kaminari.paginate_array([
      Mica.create!(
        nombre: "mica 1",
        codigo: "MC1",
        descripcion: "descripción de la mica 1",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "monofocal",
        usuario: vendedor
      ),
      Mica.create!(
        nombre: "mica 2",
        codigo: "MC2",
        descripcion: "descripción de la mica 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "monofocal",
        usuario: vendedor
      ),
    ]).page(1))
  end

  it "muestra la lista de micas" do
    render
    assert_select "tr>td", text: "10".to_s, count: 2
    assert_select "tr>td", text: "monofocal".to_s, count: 2
  end
end
