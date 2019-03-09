# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Administrador.create! nombre: 'juan', telefono: '951 123 45 67',
  email: 'admin@gmail.com', password: '123123123'

Vendedor.create! nombre: 'vendedor', telefono: '951 123 45 67',
  email: 'vendedor@gmail.com', password: '123123123'

50.times do |n|
  tipo = ['ranurado', 'armazón completo', 'sobrepuesto'].sample
  Armazon.create! nombre: "Armazon#{n}", codigo: "AZ#{n}",
    precio_venta: rand(500..900), precio_compra: rand(1..400),
    tipo: tipo, usuario: admin
end

50.times do |n|
  tipo = ['polarizado', 'filtro uv'].sample
  Lente.create! nombre: "Lente-#{n}", codigo: "LENTE #{n}",
    precio_venta: rand(500..900), precio_compra: rand(1..400),
    tipo: tipo, usuario: admin
end

Mica.create! nombre: 'Alta-Force', codigo: 'ALTA FORCE',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Anti-Bluee', codigo: 'ANTI BLUEE',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Blande', codigo: 'BLANDE',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Cr-39-w', codigo: 'CR 39 W',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Flat-Top', codigo: 'FLAT TOP',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Hi-Index', codigo: 'HI INDEX',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Photocromatico', codigo: 'PHOTOCROMATICO',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Polarizado', codigo: 'POLARIZADO',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Policarbonato', codigo: 'POLICARBONATO',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Progresivo', codigo: 'PROGRESIVO',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Mica.create! nombre: 'Transition', codigo: 'TRANSITION',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin

Tratamiento.create! nombre: 'Antireflejante', codigo: 'ANTIREFLEJANTE',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Tratamiento.create! nombre: 'Tinte azúl', codigo: 'TINTE AZÚL',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
Tratamiento.create! nombre: 'Tinte café', codigo: 'TINTE CAFÉ',
  precio_venta: rand(500..900), precio_compra: rand(1..400),
  existencia: 999999999, usuario: admin
