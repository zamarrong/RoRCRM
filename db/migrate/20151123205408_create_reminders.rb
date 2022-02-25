class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.text :text
      t.date :date

      t.timestamps
    end
  end
end
