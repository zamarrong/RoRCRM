class AddImageToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :image, :string
  end
end
