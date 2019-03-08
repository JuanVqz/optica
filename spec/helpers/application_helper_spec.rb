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

end
