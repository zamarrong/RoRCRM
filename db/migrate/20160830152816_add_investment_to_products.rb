class AddInvestmentToProducts < ActiveRecord::Migration
  def change
    add_column :products, :investment, :decimal, :precision => 16, :scale => 6, :default => 0
    add_column :products, :investment_notes, :text
    add_column :products, :price_notes, :text
    add_column :products, :profit_notes, :text
  end
end
