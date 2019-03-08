FactoryBot.define do
  factory :vendido do
    venta
    producto { nil }
    cantidad { 1 }
    precio_venta { 1 }
    precio_compra { 1 }
    descuento { 0 }
    subtotal { 1 }
    observaciones { "MyText" }
  end

  trait :es_armazon do
    before :create do |vendido|
      vendido.producto = create :armazon
    end
  end
end
