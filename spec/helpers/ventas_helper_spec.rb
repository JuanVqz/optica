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

  describe "#facturacion" do
    context "cuando facturar es true" do
      let(:venta) { create :venta, facturar: true }

      it "debe ser 'FACTURAR'" do
        expect(facturacion(venta)).to match(/FACTURAR/)
      end

      it "debe ser de color rojo" do
        expect(facturacion(venta)).to match(/danger/)
      end
    end # context cuando facturar es true

    context "cuando facturar es false" do
      let(:venta) { create :venta, facturar: false }

      it "debe ser 'NO FACTURAR'" do
        expect(facturacion(venta)).to match(/NO FACTURAR/)
      end

      it "debe ser de color azúl" do
        expect(facturacion(venta)).to match(/primary/)
      end
    end # context cuando facturar es false
  end # describe "#facturacion"

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
