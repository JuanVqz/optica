class CreateVentas < ActiveRecord::Migration[5.2]
  def change
    create_table :ventas do |t|
      t.string :codigo
      t.text :observaciones
      t.boolean :saldada, default: true
      t.timestamp :fecha_entrega, default: -> { 'NOW()' }
      t.money :descuento, default: 0
      t.money :total, default: 0
      t.references :cliente, foreign_key: true
      t.references :usuario, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
    add_index :ventas, :codigo, unique: true
  end
end
