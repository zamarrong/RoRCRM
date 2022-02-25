class AddPositionToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :position, :string
  end
end
