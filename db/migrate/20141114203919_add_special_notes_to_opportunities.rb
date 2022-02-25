class AddSpecialNotesToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :special_notes, :text
    rename_column :opportunities, :description, :payment_conditions
  end
end
