FactoryBot.define do
  factory :tratamiento do
    sequence(:nombre) { |n| "tratamiento #{n}" }
    sequence(:codigo) { |n| "TR#{n}" }
    descripcion { "MyText" }
    precio_venta { 1 }
    precio_compra { 1 }
    existencia { 1 }
    publicado { false }
    tipo { nil }
    association :usuario, factory: :vendedor
    marca
  end
end
