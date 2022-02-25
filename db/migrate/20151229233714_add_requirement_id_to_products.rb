class AddRequirementIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :requirement_id, :string
  end
end
