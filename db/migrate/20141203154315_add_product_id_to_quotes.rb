class AddProductIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :product_id, :integer
  end
end
