class AddOpportunityIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :opportunity_id, :integer
  end
end
