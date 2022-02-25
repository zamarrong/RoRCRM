class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.string :description
      t.string :brand
      t.string :model
      t.string :serial
      t.decimal :price, :precision => 16, :scale => 6
      t.text :notes
      t.boolean :is_not_here
      t.boolean :is_sold_and_here
      t.boolean :has_issues

      t.timestamps
    end
  end
end
