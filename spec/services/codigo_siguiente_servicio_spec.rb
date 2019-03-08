require 'rails_helper'

RSpec.describe CodigoSiguienteServicio do

  subject { CodigoSiguienteServicio }

  describe "#asignar" do
    context "Venta" do
      let(:venta) { build :venta }
      let(:venta_nueve) { create_list :venta, 9 }
      let(:venta_diez_y_nueve) { create_list :venta, 19 }

      it "regresa '0000000000017' si es venta 1" do
        expect(subject.new(venta).asignar).to eq '0000000000017'
      end

      it "regresa '0000000000109' si es venta 10" do
        venta_nueve
        expect(subject.new(venta).asignar).to eq '0000000000109'
      end

      it "regresa '0000000000208' si es venta 20" do
        venta_diez_y_nueve
        expect(subject.new(venta).asignar).to eq '0000000000208'
      end
    end # context "Venta"
  end # describe #asignar

end
