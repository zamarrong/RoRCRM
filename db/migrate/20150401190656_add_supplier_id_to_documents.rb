class AddSupplierIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :supplier_id, :integer
  end
end
