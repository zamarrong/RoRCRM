class AddShippingNumberToPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :shipping_number, :string
  end
end
