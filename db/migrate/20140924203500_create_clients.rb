class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :avatar
      t.string :first_name
      t.string :last_name
      t.string :organization
      t.string :position
      t.string :work_phone
      t.string :home_phone
      t.string :mobile_phone
      t.string :fax_number
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :website
      t.text :notes
      t.string :email

      t.timestamps
    end
  end
end
