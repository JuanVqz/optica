require 'rails_helper'

RSpec.describe "ventas/show", type: :view do

  let(:cliente) { create :cliente }
  let(:vendedor) { create :vendedor }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(vendedor)

    @venta = assign(:venta, Venta.create!(
      observaciones: "MyText",
      saldada: true,
      facturar: true,
      fecha_entrega: "2019-02-27 00:00:00",
      total: 100,
      forma_de_pago: '01 - Efectivo',
      cliente: cliente,
      usuario: vendedor
    ))
  end

  context "cuando no es saldada" do
    it "debe mostrar el boton editar" do
      render

      expect(rendered).to match(/si-pencil/)
    end
  end # context cuando no es saldada

  it "muestra los atributos" do
    render

    expect(rendered).to match("#{@venta.usuario}")
    expect(rendered).to match("#{@venta.cliente}")
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/100/)
    expect(rendered).to match(/01 - Efectivo/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/FACTURAR/)
  end

end
