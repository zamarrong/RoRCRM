class Quote < ActiveRecord::Base
	belongs_to :opportunity
	belongs_to :product

	mount_uploader :image, AvatarUploader

	def product_description
		if product.blank?
			return description 
		else
			return "#{product.description} #{product.brand} #{product.model} #{product.serial}"
		end
	end
end
