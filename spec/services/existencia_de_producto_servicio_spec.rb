require 'rails_helper'

RSpec.describe ExistenciaDeProductoServicio do

  describe "#descontar" do

    let(:armazon) { create :armazon, precio_venta: 100, existencia: 10 }
    let(:vendidos) do
      build_list :vendido, 2, producto: armazon, cantidad: 1,
        precio_venta: 100, subtotal: 100
    end
    let(:venta) do
      create :venta, total: 200, pagos: pagos, vendidos: vendidos
    end

    before { [armazon, venta] }

    context "cuando la venta es saldada" do
      let(:pagos) do
        build_list :pago, 1, efectivo: 500, anticipo: 200, cambio: 300
      end

      it "debe ser saldada" do
        expect(venta).to be_saldada
      end

      it "debe descontar 2 existencias del armazon" do
        expect(armazon.existencia).to eq 8
      end
    end # context cuando la venta es saldada

    context "cuando la venta es no es saldada" do
      let(:pagos) do
        build_list :pago, 1, efectivo: 500, anticipo: 100, cambio: 400
      end

      it "no debe ser saldada" do
        expect(venta).to_not be_saldada
      end

      it "no debe descontar existencia del armazon" do
        expect(armazon.existencia).to eq 10
      end
    end # context cuando la venta es no es saldada
  end # describe "#descontar"

end
