class AddNewFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :organization, :string
    add_column :users, :position, :string
    add_column :users, :work_phone, :string
    add_column :users, :home_phone, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :fax_number, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :string
    add_column :users, :country, :string
    add_column :users, :website, :string
    add_column :users, :notes, :text
    add_column :users, :admin, :boolean
  end
end
