class AddClientIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :client_id, :integer
  end
end
