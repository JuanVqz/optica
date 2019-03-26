require 'rails_helper'

RSpec.describe Venta, type: :model do

  it { should belong_to :cliente }
  it { should belong_to :usuario }
  it { should have_many(:vendidos).dependent(:destroy) }
  it { should have_many(:productos).through :vendidos }
  it { should have_many(:pagos).dependent(:destroy) }

  it { should accept_nested_attributes_for :vendidos }
  it { should accept_nested_attributes_for :pagos }

  it { should validate_presence_of :cliente }
  it { should validate_presence_of :fecha_entrega }
  it { should validate_presence_of :forma_de_pago }

  it { should_not allow_value(0).for(:total) }

  describe ".buscar" do
    let!(:ventas) { create_list :venta, 4 }
    let!(:venta) do
      create :venta, codigo: '0000000000055', total: 500,
        descuento: 300
    end

    it "regresa 1 coincidencia por código" do
      expect(Venta.buscar("0000000000055").count).to eq 1
    end

    it "regresa 1 coincidencia por total" do
      expect(Venta.buscar("500").count).to eq 1
    end

    it "regresa 1 coincidencia por descuento" do
      expect(Venta.buscar("300").count).to eq 1
    end
  end # describe ".buscar"

  describe "#suma_precios_venta" do
    context "cuando tiene productos vendidos" do
      let(:venta) do
        create :venta, :con_dos_armazones, :con_dos_micas, total: 800
      end

      it "debe ser 900" do
        venta.reload
        expect(venta.suma_precios_venta).to eq 900
      end
    end # context suma el precio_venta de los vendidos

    context "cuando no tiene productos vendidos" do
      let(:venta) { create :venta }

      it "debe ser 0" do
        expect(venta.suma_precios_venta).to eq 0
      end
    end # context cuando no tiene productos vendidos
  end # describe "#suma_precios_venta"

  describe "#suma_descuentos" do
    context "cuando tiene productos vendidos" do
      let(:venta) do
        create :venta, :con_dos_armazones, :con_dos_micas, total: 800
      end

      it "debe ser 100" do
        venta.reload
        expect(venta.suma_descuentos).to eq 100
      end
    end # context cuando tiene productos vendidos

    context "cuando no tiene productos vendidos" do
      let(:venta) { create :venta }

      it "debe ser 0" do
        expect(venta.suma_descuentos).to eq 0
      end
    end # context cuando no tiene productos vendidos
  end # describe "#suma_descuentos"

  describe "#deuda" do
    let(:pago) do
      build_list :pago, 1, efectivo: 500, anticipo: 200, cambio: 300
    end
    let(:venta) { build :venta, pagos: pago, total: 300 }

    context "cuando la venta no es saldada" do
      it "debe ser 100" do
        expect(venta.deuda).to eq 100
      end

      it "debe ser 200" do
        venta.total = 400
        expect(venta.deuda).to eq 200
      end
    end # context cuando la venta no es saldada

    context "cuando la venta es saldada" do
      it "debe ser -100" do
        venta.total = 100
        expect(venta.deuda).to eq(-100)
      end

      it "debe ser -199" do
        venta.total = 1
        expect(venta.deuda).to eq(-199)
      end
    end # context cuando la venta es saldada
  end # describe "#deuda"

  describe "#suma_anticipos" do
    context "cuando tiene pagos" do
      let(:pagos) { build_list :pago, 10 }
      let(:venta) { create :venta, pagos: pagos }

      it "debe ser 10" do
        expect(venta.suma_anticipos).to eq 10
      end
    end # context cuando tiene pagos

    context "cuando no tiene pagos" do
      let(:venta) { create :venta, pagos: nil.to_a }

      it "debe ser 0" do
        expect(venta.suma_anticipos).to eq 0
      end
    end # context cuando no tiene pagos
  end # describe "#suma_anticipos"

  describe "#centavos" do
    context "cuando el total tiene centavos" do
      let(:venta) { create :venta, total: 100.45 }

      it "debe regresar '45'" do
        expect(venta.centavos).to eq '45'
      end
    end # context cuando el total tiene centavos

    context "cuando el total no tiene centavos" do
      let(:venta) { create :venta, total: 100.00 }

      it "debe regresar '00'" do
        expect(venta.centavos).to eq '00'
      end
    end # context cuando el total no tiene centavos
  end # describe "#centavos"

  describe "#to_s" do
    let(:venta) { create :venta }

    it "debe regresar el codigo de venta" do
      expect(venta.to_s).to eq venta.codigo
    end
  end # describe "#to_s"

  describe "#comprobar_estado_de_pago" do
    let(:pago) do
      build_list :pago, 1, efectivo: 500, anticipo: 200, cambio: 300
    end

    context "cuando la venta es saldada" do
      let(:venta) { build :venta, pagos: pago, total: 200, saldada: false }

      it "saldada debe ser true" do
        expect { venta.save! }.to change { venta.saldada }
      end
    end # context cuando la venta es saldada

    context "cuando la venta no es saldada" do
      let(:venta) { build :venta, pagos: pago, total: 300, saldada: true }

      it "saldada debe ser false" do
        expect { venta.save! }.to change { venta.saldada }
      end
    end # context cuando la venta no es saldada
  end # describe "#comprobar_estado_de_pago"

  describe "#asignar_siguiente_codigo!" do
    context "cuando se crea una nueva venta" do
      let(:venta) { build :venta, codigo: nil }

      it "debe asignar siguiente código" do
        expect { venta.save! }.to change { venta.codigo }
      end
    end # context cuando se crea una nueva venta
  end # describe "#asignar_siguiente_codigo"

end
