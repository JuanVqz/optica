# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_02_230725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clientes", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "telefono"
    t.string "rfc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domicilios", force: :cascade do |t|
    t.string "calle"
    t.string "numero"
    t.string "colonia"
    t.string "codigo_postal"
    t.string "municipio"
    t.string "estado", default: "Oaxaca"
    t.string "pais", default: "México"
    t.string "domiciliable_type"
    t.integer "domiciliable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string "nombre"
    t.string "telefono"
    t.string "rfc"
    t.string "eslogan"
    t.string "logotipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pagos", force: :cascade do |t|
    t.money "efectivo", scale: 2, default: "0.0"
    t.money "anticipo", scale: 2, default: "0.0"
    t.money "cambio", scale: 2, default: "0.0"
    t.bigint "venta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venta_id"], name: "index_pagos_on_venta_id"
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "codigo", default: "", null: false
    t.text "descripcion"
    t.money "precio_venta", scale: 2, default: "0.0"
    t.money "precio_compra", scale: 2, default: "0.0"
    t.integer "existencia", default: 1
    t.string "tipo"
    t.string "type"
    t.json "imagenes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.index ["usuario_id"], name: "index_productos_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.integer "cargo", default: 0, null: false
    t.boolean "activo", default: true, null: false
    t.string "telefono"
    t.string "type"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "vendidos", force: :cascade do |t|
    t.bigint "venta_id"
    t.bigint "producto_id"
    t.integer "cantidad", default: 1, null: false
    t.money "precio_venta", scale: 2, default: "0.0"
    t.money "precio_compra", scale: 2, default: "0.0"
    t.money "descuento", scale: 2, default: "0.0", null: false
    t.money "subtotal", scale: 2, default: "0.0", null: false
    t.text "observaciones"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["producto_id"], name: "index_vendidos_on_producto_id"
    t.index ["venta_id"], name: "index_vendidos_on_venta_id"
  end

  create_table "ventas", force: :cascade do |t|
    t.string "codigo"
    t.text "observaciones"
    t.boolean "saldada", default: true
    t.datetime "fecha_entrega", default: -> { "now()" }
    t.money "descuento", scale: 2, default: "0.0"
    t.money "total", scale: 2, default: "0.0"
    t.bigint "cliente_id"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_ventas_on_cliente_id"
    t.index ["codigo"], name: "index_ventas_on_codigo", unique: true
    t.index ["usuario_id"], name: "index_ventas_on_usuario_id"
  end

  add_foreign_key "pagos", "ventas"
  add_foreign_key "productos", "usuarios"
  add_foreign_key "vendidos", "productos"
  add_foreign_key "vendidos", "ventas"
  add_foreign_key "ventas", "clientes"
  add_foreign_key "ventas", "usuarios"
end
