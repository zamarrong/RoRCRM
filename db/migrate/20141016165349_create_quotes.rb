class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :description
      t.decimal :quantity, :precision => 16, :scale => 6
      t.decimal :price, :precision => 16, :scale => 6

      t.timestamps
    end
  end
end
