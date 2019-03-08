require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do

  describe ".recientes_primero" do
    context "Armazon" do
      let(:armazon_ayer) { create :armazon, created_at: 1.day.ago }
      let(:armazon_hoy) { create :armazon, created_at: Date.current }

      it "debe mostrar el último creado" do
        expect(Armazon.recientes_primero).to eq [armazon_hoy, armazon_ayer]
      end
    end # context Armazon

    context "Cliente" do
      let(:cliente_ayer) { create :cliente, created_at: 1.day.ago }
      let(:cliente_hoy) { create :cliente, created_at: Date.current }

      it "debe mostrar el último primero" do
        expect(Cliente.recientes_primero).to eq [cliente_hoy, cliente_ayer]
      end
    end # context Cliente

    context "Empresa" do
      let(:empresa_ayer) { create :empresa, created_at: 1.day.ago }
      let(:empresa_hoy) { create :empresa, created_at: Date.current }

      it "debe mostrar el último primero" do
        expect(Empresa.recientes_primero).to eq [empresa_hoy, empresa_ayer]
      end
    end # context Empresa

    context "Lente" do
      let(:lente_ayer) { create :lente, created_at: 1.day.ago }
      let(:lente_hoy) { create :lente, created_at: Date.current }

      it "debe mostrar el último primero" do
        expect(Lente.recientes_primero).to eq [lente_hoy, lente_ayer]
      end
    end # context Lente

    context "Mica" do
      let(:mica_ayer) { create :mica, created_at: 1.day.ago }
      let(:mica_hoy) { create :mica, created_at: Date.current }

      it "debe mostrar el último primero" do
        expect(Mica.recientes_primero).to eq [mica_hoy, mica_ayer]
      end
    end # context Mica

    context "Tratamiento" do
      let!(:tratamiento_ayer) { create :tratamiento, created_at: 1.day.ago }
      let!(:tratamiento_hoy) { create :tratamiento, created_at: Date.current }

      it "debe mostrar el último primero" do
        expect(Tratamiento.recientes_primero).to eq [tratamiento_hoy, tratamiento_ayer]
      end
    end # context Tratamiento

    context "Vendedor" do
      let!(:vendedor_ayer) { create :vendedor, created_at: 1.day.ago }
      let!(:vendedor_hoy) { create :vendedor, created_at: Date.current }

      it "debe mostrar el último primero" do
        expect(Vendedor.recientes_primero).to eq [vendedor_hoy, vendedor_ayer]
      end
    end # context Vendedor

    context "Venta" do
      let!(:venta_de_ayer) { create :venta, created_at: 1.day.ago }
      let!(:venta_de_hoy) { create :venta, created_at: Date.current }

      it "debe mostrar la última venta creada primero" do
        expect(Venta.recientes_primero).to eq [venta_de_hoy, venta_de_ayer]
      end
    end # context Venta

  end # describe ".recientes_primero"

end
