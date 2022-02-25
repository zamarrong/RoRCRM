class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.integer :client_id
      t.integer :user_id
      t.string :currency
      t.string :valuation
      t.string :how_was_it_found
      t.date :opening_date
      t.date :due_date
      t.float :tax
      t.decimal :price
      t.boolean :closed
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
