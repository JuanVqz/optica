require 'rails_helper'

RSpec.describe CodigoDeBarrasServicio do

  subject { CodigoDeBarrasServicio }

  describe "#convertir" do
    let(:venta) { create :venta, codigo: "0000000000017" }
    let(:producto) { create :armazon, codigo: 'ARMAZON1' }

    it "debe ser un svg" do
      expect(subject.new(venta).convertir).to match(/svg/)
      expect(subject.new(producto).convertir).to match(/svg/)
    end

    it "no debe ser una imagen" do
      expect(subject.new(venta).convertir).to_not match(/img/)
      expect(subject.new(producto).convertir).to_not match(/img/)
    end

    context "ean_13" do
      it "debe contenter '0000000000017'" do
        expect(subject.new(venta).convertir).to match(venta.codigo)
      end
    end # context ean_13

    context "code_128" do
      it "debe contenter 'ARMAZON1'" do
        expect(subject.new(producto).convertir).to match(producto.codigo)
      end
    end # context code_128
  end # describe "#convertir"

end
