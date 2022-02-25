class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy, :sell, :return]

	def index
		@headers = {
			:description_string => :desc,
			:brand_string => :desc,
			:price => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :description_string
		direction = params[:direction] || :asc

		@search = Product.search do
			fulltext params[:search]
			paginate :page => params[:page], :per_page => 1000
			order_by order, direction
		end

		@current_inventory = params[:current_inventory] || 'inventory'

		@products = @search.results
		respond_to do |format|
			format.html
			format.json { render json: Product.find_by(code: params[:code]) }
			format.xlsx { render xlsx: 'products',filename: "inventario.xlsx"}
		end
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.create(product_params)
		redirect_to product_path(@product)
	end

	def update
		@product.update(product_params)
		redirect_to product_path(@product)
	end

	def sell
		@product.update(:sold => true)
		redirect_to products_path
	end

	def return
		@product.update(:sold => false)
		redirect_to products_path
	end

	def destroy
		@product.destroy
		redirect_to products_path
	end

	def import
	  Product.import(params[:file])
	  redirect_to products_path, notice: "Products imported."
	end

	private
	def set_product
		@product = Product.find(params[:id])
	end

	def product_params
		params.require(:product).permit(:video, :code, :description, :brand, :model, :serial, :price, :notes, :is_not_here, :is_sold_and_here, :has_issues, :image, :year, :requirement_id, :investment, :investment_notes, :price_notes, :profit_notes, :costs_attributes => [:id, :_destroy, :total, :notes])
	end
end
