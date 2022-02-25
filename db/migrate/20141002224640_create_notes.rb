class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.date :date
      t.text :content
      t.integer :client_id

      t.timestamps
    end
  end
end
