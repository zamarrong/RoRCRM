class AddIsForHfToProductos < ActiveRecord::Migration
  def change
    add_column :products, :is_for_hf, :boolean
  end
end
