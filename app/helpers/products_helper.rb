module ProductsHelper
	def product_image(product)
		if product.image.blank?
			image_tag 'avatar_blank.png'
		else
			image_tag product.image
		end
	end
end
