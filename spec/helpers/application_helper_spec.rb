require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "#codigo_de_barras" do
    context "Venta" do
      let(:venta) { create :venta, codigo: '0000000000017' }

      it "debe ser '0000000000017'" do
        expect(codigo_de_barras venta ).to match venta.codigo
      end
    end # context Venta

    context "Producto" do
      let(:producto) { create :armazon, codigo: 'ARMAZON1' }

      it "debe ser 'ARMAZON1'" do
        expect(codigo_de_barras producto ).to match producto.codigo
      end
    end # context Armazon
  end # describe "#codigo_de_barras"

  describe "#ruta_actual" do
    let(:ruta) { double('request', path: '/ventas') }

    before { allow(helper).to receive(:request).and_return ruta }

    context "cuando es la ruta actual" do
      it "debe regresar 'active'" do
        expect(helper.ruta_actual(ventas_path)).to eq 'active'
      end
    end # context cuando es la ruta actual

    context "cuando no es la ruta actual" do
      it "debe regresar false" do
        expect(helper.ruta_actual('/otra_ruta')).to be_falsey
      end
    end # context cuando no es la ruta actual
  end # describe "#ruta_actual"

end
