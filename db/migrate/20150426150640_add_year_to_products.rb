class AddYearToProducts < ActiveRecord::Migration
  def change
    add_column :products, :year, :string
  end
end
