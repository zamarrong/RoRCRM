class AddClosedDateToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :closed_date, :date
  end
end
