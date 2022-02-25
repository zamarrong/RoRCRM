class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :client_id
      t.integer :user_id
      t.text :description
      t.date :date
      t.text :budget

      t.timestamps
    end
  end
end
