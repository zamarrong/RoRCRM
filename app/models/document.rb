class Document < ActiveRecord::Base
	mount_uploader :content, DocumentUploader
	belongs_to :client
	belongs_to :supplier

	after_save :reindex_parent
	after_destroy :reindex_parent

	def reindex_parent
		if not client.blank?
			Sunspot.index(client)
		elsif not supplier.blank?
			Sunspot.index(supplier)
		end
	end
end
