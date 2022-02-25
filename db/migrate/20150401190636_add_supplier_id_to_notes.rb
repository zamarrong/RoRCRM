class AddSupplierIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :supplier_id, :integer
  end
end
