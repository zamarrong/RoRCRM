class ChangeDateFormatInNotes < ActiveRecord::Migration
  def change
  	change_column :notes, :date, :datetime
  end
end
