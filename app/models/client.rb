class Client < ActiveRecord::Base
	has_many :opportunities, dependent: :destroy
	mount_uploader :avatar, AvatarUploader

	has_many :contacts, dependent: :destroy
	accepts_nested_attributes_for :contacts, :allow_destroy => true

	has_many :notes, dependent: :destroy
	has_many :documents, dependent: :destroy
	has_many :requirements

	validates :name, :uniqueness => true



	searchable do
		text :name
		text :contact_name do
			contacts.map(&:name)
		end
		text :contact_email do
			contacts.map(&:email)
		end
		text :note_text do
			notes.map(&:content)
		end
		string :state
		string :client_name do
			name
		end
	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			 row = Array[[spreadsheet.row(i)].transpose]
			 if row[0][1][0] == 's/p' or row[0][1][0] == 'S/p'
			 	website = nil
			 else
			 	website = row[0][1][0]
			 end
			 if row[0][6][0] == 'Mexico'
			 	country = 'México'
			 else
			 	country = row[0][6][0]
			 end
			 if row[0][7][0].blank?
			 	contact_name = 'A quien Corresponda'
			 else
			 	contact_name = row[0][7][0]
			 end
			 if row[0][9][0].blank?
			 	telephone_2 = ''
			 else
			 	telephone_2 = row[0][9][0].to_i.to_s
			 end
			 if row[0][5][0].blank?
			 	zip_code = ''
			 else
			 	zip_code = row[0][5][0].to_i.to_s
			 end
			 client = Client.create_with(:website => website, :address => row[0][2][0], :city => row[0][3][0], :state => row[0][4][0].titleize, :zip_code => zip_code, :country => country).find_or_create_by_name(row[0][0][0])
			 contact = Contact.create(:telephone => row[0][8][0].to_i.to_s, :telephone_2 => telephone_2, :email => row[0][10][0], :client_id => client.id, :name => contact_name)
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

end
