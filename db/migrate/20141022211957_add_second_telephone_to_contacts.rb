class AddSecondTelephoneToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :telephone_2, :string
  end
end
