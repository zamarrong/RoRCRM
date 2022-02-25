class AddDefaultsToPurchaseItems < ActiveRecord::Migration
  def change
  	 change_column :purchase_items, :quantity, :float, default: 0
  	 change_column :purchase_items, :price, :decimal, :precision => 16, :scale => 6, default: 0
  end
end
