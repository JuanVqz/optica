FactoryBot.define do
  factory :venta do
    codigo { nil }
    observaciones { "MyText" }
    saldada { true }
    facturar { false }
    fecha_entrega { "2019-02-06 18:04:16" }
    descuento { 0 }
    total { 1 }
    forma_de_pago { ['01', '02', '03', '04', '28'].sample }
    cliente
    association :usuario, factory: :vendedor

    before :create do |venta|
      create_list :pago, 1, venta: venta if venta.pagos.empty?
    end
  end

  trait :con_dos_armazones do
    after :create do |venta|
      armazon = create :armazon

      create :vendido, precio_venta: 250, precio_compra: 50,
        cantidad: 2, descuento: 50, subtotal: 450,
        venta: venta, producto: armazon
    end
  end

  trait :con_dos_micas do
    after :create do |venta|
      mica = create :mica

      create :vendido, precio_venta: 200, precio_compra: 50,
        cantidad: 2, descuento: 50, subtotal: 350,
        venta: venta, producto: mica
    end
  end
end
