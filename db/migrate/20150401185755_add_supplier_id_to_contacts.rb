class AddSupplierIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :supplier_id, :integer
  end
end
