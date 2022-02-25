class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :company
      t.string :language
      t.integer :supplier_id
      t.integer :contact_id
      t.integer :shipping_address_id
      t.string :currency
      t.date :opening_date
      t.decimal :shipping_and_handling, :precision => 16, :scale => 6
      t.decimal :other_charges, :precision => 16, :scale => 6
      t.text :special_notes
      t.integer :folio

      t.timestamps
    end
  end
end
