require 'rails_helper'

RSpec.describe "ventas/index", type: :view do

  let(:cliente) { create :cliente }
  let(:vendedor) { create :vendedor }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(vendedor)

    assign(:ventas, Kaminari.paginate_array([
      Venta.create!(
        observaciones: "MyText",
        saldada: true,
        facturar: true,
        fecha_entrega: "2019-02-27 00:00:00",
        total: 1,
        forma_de_pago: '01 - Efectivo',
        cliente: cliente,
        usuario: vendedor
      ),
      Venta.create!(
        observaciones: "MyText",
        saldada: true,
        facturar: false,
        fecha_entrega: "2019-02-27 00:00:00",
        total: 1,
        forma_de_pago: '02 - Cheque nominativo',
        cliente: cliente,
        usuario: vendedor
      )
    ]).page(1))
  end

  context "cuando no es saldada" do
    it "debe mostrar el boton editar" do
      render

      expect(rendered).to match(/si-pencil/)
    end
  end # context cuando no es saldada

  it "muestra los atributos" do
    render

    assert_select "tr>td", text: "FACTURAR".to_s, count: 1
    assert_select "tr>td", text: "NO FACTURAR".to_s, count: 1
    assert_select "tr>td", text: "PENDIENTE".to_s, count: 2
    assert_select "tr>td", text: "$1.00".to_s, count: 4
  end

end
