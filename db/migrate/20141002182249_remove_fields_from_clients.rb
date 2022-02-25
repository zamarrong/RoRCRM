class RemoveFieldsFromClients < ActiveRecord::Migration
  def change
  	remove_column :clients, :work_phone
  	remove_column :clients, :home_phone
  	remove_column :clients, :first_name
  	remove_column :clients, :last_name
  	remove_column :clients, :position
  	remove_column :clients, :organization
  	remove_column :clients, :mobile_phone
  	remove_column :clients, :fax_number
  	remove_column :clients, :email
  	remove_column :clients, :notes
  	add_column :clients, :name, :string
  end
end
