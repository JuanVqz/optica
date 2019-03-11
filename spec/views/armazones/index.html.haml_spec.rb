require 'rails_helper'

RSpec.describe "armazones/index", type: :view do
  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  before(:each) do
    assign(:armazones, Kaminari.paginate_array([
      Armazon.create!(
        nombre: "armazon 1",
        codigo: "AZ1",
        descripcion: "descripción del armazones 1",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "ranurado",
        usuario: vendedor,
        marca: marca
      ),
      Armazon.create!(
        nombre: "armazon 2",
        codigo: "AZ2",
        descripcion: "descripción del armazones 2",
        precio_venta: 100,
        precio_compra: 0,
        existencia: 10,
        tipo: "sobrepuesto",
        usuario: vendedor,
        marca: marca
      ),
    ]).page(1))
  end

  it "muestra la lista de armazones" do
    render
    assert_select "tr>td", :text => "10".to_s, :count => 2
    assert_select "tr>td", :text => "ranurado".to_s, :count => 1
  end
end
