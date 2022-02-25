class Product < ActiveRecord::Base
	has_many :quotes
	has_many :costs
	has_many :opportunities, through: :quotes

	accepts_nested_attributes_for :costs, :allow_destroy => true

	mount_uploader :image, AvatarUploader

	searchable do
		text :code
		text :description
		text :brand
		text :model
		text :serial
		string :description_string do
			description
		end
		string :brand_string do
			brand
		end
		float :price
	end

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  (1..spreadsheet.last_row).each do |i|
	    row = spreadsheet.row(i)
	   	product = find_by_code(row[7]) || new
	   	product.update_attributes(code: row[7], description: row[0], price: row[17], is_for_hf:true)
	   	product.save!
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
	  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	def profit
		total = price.to_f - investment.to_f
		costs.each do |cost|
			total -= cost.total
		end
		return total
	end
end
