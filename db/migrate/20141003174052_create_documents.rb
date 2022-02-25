class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :client_id
      t.string :content

      t.timestamps
    end
  end
end
