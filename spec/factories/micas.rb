FactoryBot.define do
  factory :mica do
    sequence(:nombre) { |n| "mica #{n}" }
    sequence(:codigo) { |n| "MC#{n}" }
    descripcion { "MyText" }
    precio_venta { 1 }
    precio_compra { 1 }
    existencia { 1 }
    publicado { false }
    tipo { ['policarbonato', 'monofocal'].sample }
    association :usuario, factory: :vendedor
    marca
  end
end
