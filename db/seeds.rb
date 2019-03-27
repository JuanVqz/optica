
def asignar_imagen nombre
  File.open(File.join(Rails.root, "/spec/fixtures/files/#{nombre}"))
end

# EMPRESAS
Tienda.create! nombre: 'Optica J&J', telefono: '951 111 2233',
  eslogan: 'Viste tu vista con el mejor accesorio',
  logotipo: asignar_imagen('opticajj.jpg'), pagina_web: 'http://optica.com',
  domicilio: Domicilio.new(calle: 'una calle', numero: '8', colonia: 'la colonia',
  codigo_postal: '68000', municipio: 'Oaxaca de Júarez')

Corporacion.create! nombre: 'Público en general',
  domicilio: Domicilio.new(calle: 'otra calle', numero: '100',
  colonia: 'otra colonia', codigo_postal: '68258', municipio: 'San Pablo Etla')

# USUARIOS
Administrador.create! nombre: 'Administrador', telefono: '951 123 45 67',
  email: 'admin@gmail.com', password: '123123123'

vendedor = Vendedor.create! nombre: 'vendedor', telefono: '951 123 45 67',
  email: 'vendedor@gmail.com', password: '123123123'

# MARCAS
marca = Marca.create! nombre: 'SIN ASIGNAR'
oakley = Marca.create! nombre: 'OAKLEY'
dolce = Marca.create! nombre: 'DOLCE&GABANA'
prada = Marca.create! nombre: 'PRADA'

# ARMAZONES
armazones = [
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3217-0355138', descripcion: 'OAKLEY SATIN BRUSHED CHROME', precio_venta: 3450, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3173-0157139', descripcion: '', precio_venta: 4300, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3227-0355139', descripcion: 'FULLER POLISHED BLACK METALICO NEGRO', precio_venta: 3900, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3227-0255139', descripcion: 'FULLER PEWTER METALICO BRONCE', precio_venta: 3900, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX5124-0155143', descripcion: 'TRUSS ROD METALICO NEGRO', precio_venta: 4900, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3173-0552139', descripcion: 'BARRELHOUSE MATTE BLACK', precio_venta: 4100, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX8131-04545417138', descripcion: 'FROGSKINS ACETATO NEGRO', precio_venta: 3400, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX8131-06545417138', descripcion: 'FROGSKINS ACETATO TRANSPARENTE', precio_venta: 3400, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3217-0155138', descripcion: 'SOCKET 5.0 SATIN BLACK METALICO NEGRO', precio_venta: 3900, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3227-0455139', descripcion: 'FULLER MATTE MIDRIGHT METALICO AZUL', precio_venta: 4100, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX5126-0454137', descripcion: 'GAUGE 3.1 POLISHED BLACK 3 PZAS COLOR NEGRO', precio_venta: 4980, existencia: 1, tipo: 'armazón de tres piezas', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX5118-0353139', descripcion: 'WINGFOLD EVR POLISHED CEMENT 3PZAS COLOR GRIS', precio_venta: 4980, existencia: 1, tipo: 'armazón de tres piezas', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX8103-0249140', descripcion: 'STEEL LINER MATTE BLACK INK ACETATO NEGRO MATTE', precio_venta: 3980, existencia: 1, tipo: 'armazón completo', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX3218-0154138', descripcion: 'SOCKET 5.5 POLISHED BLACK 138 ARM RANURADO AZUL', precio_venta: 4700, existencia: 1, tipo: 'ranurado', marca_id: oakley.id, usuario: vendedor },
  { nombre: 'OAKLEY OFTALMICO', codigo: 'OX5119-0254139', descripcion: 'LIMIT SWITCH 0.5 SATIN PEWTER ARM RANURADO CAFE', precio_venta: 4900, existencia: 1, tipo: 'ranurado', marca_id: oakley.id, usuario: vendedor },

  { nombre: 'DOLCE&GABANA OFTALMICO  DG5024', codigo: '31015318140', descripcion: 'DOLCE&GABANA ACETATO GRIS VARILLAS METALICAS', precio_venta: 6500, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG5024', codigo: '30945518145', descripcion: 'DOLCE&GABANA ACETATO AZUL VARILLAS METALICAS', precio_venta: 6500, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG5023', codigo: '30675418150', descripcion: 'DOLCE&GABANA ACETATO AZUL VARILLAS METALICAS', precio_venta: 6400, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3262', codigo: '30905320140', descripcion: 'DOLCE&GABANA ACETATO GRIS COMPLETO', precio_venta: 6500, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3242', codigo: '5025018145', descripcion: 'DOLCE&GABANA ACETATO CAREY VARILLAS DORADAS', precio_venta: 6400, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3268', codigo: '30975018140', descripcion: 'DOLCE&GABANA ACETATO ROJO COMPLETO', precio_venta: 6700, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG1268', codigo: '12555416140', descripcion: 'DOLCE&GABANA METALICO VINO/DORADO', precio_venta: 6800, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG1289', codigo: '4885417145', descripcion: 'DOLCE&GABANA METALICO DORADO', precio_venta: 6700, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG1289', codigo: '045417145', descripcion: 'DOLCE&GABANA METALICO GRIS', precio_venta: 6600, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3257', codigo: '30645419145', descripcion: 'DOLCE&GABANA ACETATO MORADO CONFETTI', precio_venta: 6800, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3257', codigo: '30655419145', descripcion: 'DOLCE&GABANA ACETATO AZUL/NEGRO', precio_venta: 6800, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3248', codigo: '29255220 140', descripcion: 'DOLCE&GABANA ACETATO CAREY', precio_venta: 6800, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG3255', codigo: '5025318140', descripcion: 'DOLCE&GABANA ACETATO CAREY COMPLETO', precio_venta: 6700, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },
  { nombre: 'DOLCE&GABANA OFTALMICO  DG5023', codigo: '28055418150', descripcion: 'DOLCE&GABANA ACETATO MATTE NEGRO VARILLAS METALICAS', precio_venta: 6500, existencia: 1, tipo: 'armazón completo', marca_id: dolce.id, usuario: vendedor },

  { nombre: 'PRADA OFTALMICO VPS08G', codigo: '5418UR6-1O1145', descripcion: 'PRADA ACETATO GRIS VARILLAS AZUL', precio_venta: 5900, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
  { nombre: 'PRADA OFTALMICO VPS04F', codigo: '5517DG0-1O1140', descripcion: 'PRADA ACETATO NEGRO', precio_venta: 5800, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
  { nombre: 'PRADA OFTALMICO VPS09G', codigo: '5518UR5-1O1140', descripcion: 'PRADA ACETATO NEGRO', precio_venta: 5900, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
  { nombre: 'PRADA OFTALMICO VPS01H', codigo: '5221DG0-1O1140', descripcion: 'PRADA ACETATO NEGRO CON DOBLE PUENTE', precio_venta: 5900, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
  { nombre: 'PRADA OFTALMICO VPS04H', codigo: '5319U61-1O1140', descripcion: 'PRADA ACETATO CAREY VARILLAS METALICAS', precio_venta: 5600, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
  { nombre: 'PRADA OFTALMICO VPS03H', codigo: '5518DG0-1O1140', descripcion: 'PRADA ACETATO NEGRO VARILLAS METALICAS', precio_venta: 5700, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
  { nombre: 'PRADA OFTALMICO VPS04H', codigo: '5319DG0-1O1140', descripcion: 'PRADA ACETATO NEGRO VARILLAS METALICAS', precio_venta: 5700, existencia: 1, tipo: 'armazón completo', marca_id: prada.id, usuario: vendedor },
]
Armazon.create! armazones

# MICAS
micas = [
  { nombre: 'Alta-Force', codigo: 'ALTA FORCE', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Anti-Bluee', codigo: 'ANTI BLUEE', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Blande', codigo: 'BLANDE', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Cr-39-w', codigo: 'CR 39 W', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Flat-Top', codigo: 'FLAT TOP', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Hi-Index', codigo: 'HI INDEX', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Photocromatico', codigo: 'PHOTOCROMATICO', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Polarizado', codigo: 'POLARIZADO', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Policarbonato', codigo: 'POLICARBONATO', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Progresivo', codigo: 'PROGRESIVO', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Transition', codigo: 'TRANSITION', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
]
Mica.create! micas

# TRATAMIENTOS
tratamientos = [
  { nombre: 'Antireflejante', codigo: 'ANTIREFLEJANTE', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Tinte azúl', codigo: 'TINTE AZÚL', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
  { nombre: 'Tinte café', codigo: 'TINTE CAFÉ', precio_venta: rand(500..900), existencia: 999999999, usuario: vendedor, marca_id: marca.id },
]
Tratamiento.create! tratamientos
