FactoryBot.define do
  factory :lente do
    sequence(:nombre) { |n| "lente #{n}" }
    sequence(:codigo) { |n| "LT#{n}" }
    descripcion { "MyText" }
    precio_venta { 1 }
    precio_compra { 1 }
    existencia { 1 }
    tipo { ['polarizado', 'filtro uv'].sample }
    association :usuario, factory: :vendedor
  end
end
