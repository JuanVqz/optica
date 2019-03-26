require 'rails_helper'

RSpec.describe VentasHelper, type: :helper do

  describe "#total_en_letras" do
    context "cuando el número es entero" do
      let(:venta) { create :venta, total: 150 }

      it "debe regresar 'ciento cincuenta pesos con cero centavos'" do
        letras = "ciento cincuenta pesos con cero centavos"
        expect(total_en_letras(venta)).to eq letras
      end
    end # context cuando el número es entero

    context "cuando el número tiene centavos" do
      let(:venta) { create :venta, total: 150.33 }

      it "debe regresar 'ciento cincuenta pesos con trainta y tres centavos'" do
        letras = "ciento cincuenta pesos con treinta y tres centavos"
        expect(total_en_letras(venta)).to eq letras
      end
    end # context cuando el número tiene centavos
  end # describe "#total_en_letras"

  describe "#estado_de_pago" do
    context "cuando una venta es saldada" do
      let(:pago) { build_list :pago, 1, efectivo: 100, anticipo: 100 }
      let(:venta) { create :venta, pagos: pago, total: 100, saldada: true }

      it "debe ser 'PAGADO'" do
        expect(estado_de_pago(venta)).to match(/PAGADO/)
      end
    end # context cuando una venta es saldada

    context "cuando una venta es deudora" do
      let(:pago) { build_list :pago, 1, efectivo: 1, anticipo: 1 }
      let(:venta) { create :venta, pagos: pago, total: 100, saldada: false }

      it "debe ser 'PENDIENTE'" do
        expect(estado_de_pago(venta)).to match(/PENDIENTE/)
      end
    end # context cuando una venta es deudora
  end # describe ".estado"
end
