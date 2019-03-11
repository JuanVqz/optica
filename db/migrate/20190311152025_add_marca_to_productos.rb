class AddMarcaToProductos < ActiveRecord::Migration[5.2]
  def change
    add_reference :productos, :marca, foreign_key: true
  end
end
