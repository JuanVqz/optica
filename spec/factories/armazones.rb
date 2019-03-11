FactoryBot.define do
  factory :armazon do
    sequence(:nombre) { |n| "armazon #{n}" }
    sequence(:codigo) { |n| "AZ#{n}" }
    descripcion { "MyText" }
    precio_venta { 1 }
    precio_compra { 1 }
    existencia { 1 }
    publicado { false }
    tipo { ['ranurado', 'sobrepuesto'].sample }
    association :usuario, factory: :vendedor
    marca
  end
end
