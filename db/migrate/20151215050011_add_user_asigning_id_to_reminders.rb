class AddUserAsigningIdToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :user_assigning_id, :integer
  end
end
