class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.text :terms
      t.string  :avatar
      t.string  :address
      t.string  :city
      t.string  :state
      t.string  :zip_code
      t.string  :country
      t.string  :website
      t.string  :name
      t.string  :company

      t.timestamps
    end
  end
end
