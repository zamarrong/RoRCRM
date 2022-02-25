class Contact < ActiveRecord::Base
	belongs_to :client
	belongs_to :supplier
	has_many :opportunities

	before_save :set_telephones

	searchable do
		text :name
	end

	after_save :reindex_parent
	after_destroy :reindex_parent

	def reindex_parent
		if not client.blank?
			Sunspot.index(client)
		elsif not supplier.blank?
			Sunspot.index(supplier)
		end
	end

	def set_telephones
		tel_1 = self.telephone.gsub(/\D/,'')
		t1 = tel_1
		if tel_1.length >= 10
		t1 = '(' + tel_1.at(-10..-8) + ') ' + tel_1.at(-7..-5) + '-' + tel_1.at(-4..-1)
		end
		if tel_1.length > 10 
			t1 = tel_1.at(0..-11) + ' ' + t1
		end
		self.telephone = t1

		tel_2 = self.telephone_2.gsub(/\D/,'')
		t2 = tel_2
		if tel_2.length >= 10
		t2 = '(' + tel_2.at(-10..-8) + ') ' + tel_2.at(-7..-5) + '-' + tel_2.at(-4..-1)
		end
		if tel_2.length > 10 
			t2 = tel_2.at(0..-11) + ' ' + t2
		end
		self.telephone_2 = t2
	end
end
