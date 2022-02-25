class CreatePurchaseItems < ActiveRecord::Migration
  def change
    create_table :purchase_items do |t|
      t.float :quantity
      t.string :part_number
      t.string :description
      t.decimal :price, :precision => 16, :scale => 6
      t.integer :purchase_order_id

      t.timestamps
    end
  end
end
