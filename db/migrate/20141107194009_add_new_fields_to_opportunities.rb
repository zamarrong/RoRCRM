class AddNewFieldsToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :company, :string
    add_column :opportunities, :folio, :integer
    add_column :clients, :company, :string
  end
end
