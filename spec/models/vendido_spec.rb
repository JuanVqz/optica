require 'rails_helper'

RSpec.describe Vendido, type: :model do
  it { should belong_to :venta }
  it { should belong_to :producto }

  it { should validate_presence_of :cantidad }
  it { should validate_presence_of :precio_compra }
  it { should validate_presence_of :precio_venta }
  it { should validate_presence_of :descuento }
  it { should validate_presence_of :subtotal }

  it { should_not allow_value(0).for(:cantidad) }
  it { should_not allow_value(0).for(:precio_venta) }
  it { should_not allow_value(0).for(:subtotal) }
  it { should validate_numericality_of(:precio_compra)
        .is_greater_than_or_equal_to(0) }

  describe "#to_s" do
    let(:vendido) { create :vendido, :es_armazon }

    it "debe regresar el código de producto" do
      expect(vendido.to_s).to eq vendido.producto.codigo
    end
  end # describe "#to_s"
end
