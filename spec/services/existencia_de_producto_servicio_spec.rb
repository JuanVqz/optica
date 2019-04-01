require 'rails_helper'

RSpec.describe ExistenciaDeProductoServicio do

  subject { described_class }

  describe "#descontar" do
    let!(:armazon) { create :armazon, precio_venta: 100, existencia: 10 }
    let(:vendidos) do
      build_list :vendido, 2, producto: armazon, cantidad: 1,
        precio_venta: 100, subtotal: 100
    end
    let(:venta) do
      create :venta, total: 200, pagos: pagos, vendidos: vendidos
    end

    context "cuando la venta es saldada" do
      let(:pagos) do
        build_list :pago, 1, efectivo: 500, anticipo: 200, cambio: 300
      end

      it "debe ser saldada" do
        expect(venta).to be_saldada
      end

      it "armazon debe tener 8 existencias" do
        expect {
          subject.new(venta).descontar
        }.to change { armazon.existencia }.from(10).to(8)
      end
    end # context cuando la venta es saldada

    context "cuando la venta es no es saldada" do
      let(:pagos) do
        build_list :pago, 1, efectivo: 500, anticipo: 100, cambio: 400
      end

      it "no debe ser saldada" do
        expect(venta).to_not be_saldada
      end

      it "armazon no debe cambiar la existencia" do
        expect {
          subject.new(venta).descontar
        }.not_to change { armazon.existencia }
      end
    end # context cuando la venta es no es saldada
  end # describe "#descontar"

end
