class Supplier < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	has_many :contacts, dependent: :destroy
	accepts_nested_attributes_for :contacts, :allow_destroy => true

	has_many :purchase_orders

	has_many :notes, dependent: :destroy
	has_many :documents, dependent: :destroy

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
		string :supplier_name do
			name
		end
	end
end
