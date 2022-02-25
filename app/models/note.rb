class Note < ActiveRecord::Base
	belongs_to :client
	belongs_to :supplier
	belongs_to :user

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
