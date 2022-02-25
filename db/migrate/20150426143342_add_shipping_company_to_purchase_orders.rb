class AddShippingCompanyToPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :shipping_company, :string
  end
end
