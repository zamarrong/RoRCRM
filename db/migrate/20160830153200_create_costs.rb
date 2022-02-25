class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.integer :product_id
      t.decimal :total
      t.text :notes

      t.timestamps
    end
  end
end
