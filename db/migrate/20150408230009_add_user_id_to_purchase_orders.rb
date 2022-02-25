class AddUserIdToPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :user_id, :integer
  end
end
