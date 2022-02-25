class AddContactIdToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :contact_id, :integer
  end
end
