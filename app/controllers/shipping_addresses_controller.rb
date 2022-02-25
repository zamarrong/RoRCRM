class ShippingAddressesController < ApplicationController
	before_action :set_shipping_address, only: [:show, :edit, :update, :destroy]


	def index
		@shipping_addresses = ShippingAddress.all
	end
	
	def new
		@shipping_address = ShippingAddress.new
	end

	def create
		@shipping_address = ShippingAddress.create(shipping_address_params)
		redirect_to shipping_addresses_path
	end

	def update
		@shipping_address.update(shipping_address_params)
		redirect_to shipping_addresses_path
	end

	def destroy
		@shipping_address.destroy
		redirect_to shipping_addresses_path
	end

	private
	def set_shipping_address
		@shipping_address = ShippingAddress.find(params[:id])
	end

	def shipping_address_params
		params.require(:shipping_address).permit(:name,:address,:city,:state,:zip_code, :telephone_1, :telephone_2)
	end
end
