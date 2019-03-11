FactoryBot.define do
  factory :producto do
    nombre { "MyString" }
    sequence(:codigo) { |n| "#{n}234" }
    descripcion { "MyText" }
    precio_venta { 1 }
    precio_compra { 1 }
    existencia { 1 }
    publicado { false }
    tipo { nil }
    marca
  end
end
