class PurchaseOrdersController < ApplicationController
	before_action :set_purchase_order, only: [:update, :show, :edit, :destroy]

	def index
		@headers = {
			:supplier => :desc,
			:user_name => :desc,
			:opening_date => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :created_at
		direction = params[:direction] || :desc
		@search = PurchaseOrder.search(:include => [:supplier,:user]) do
			fulltext params[:search]
			order_by order, direction
			paginate :page => params[:page]
		end
		@purchase_orders = @search.results
	end
	
	def new
		@purchase_order = PurchaseOrder.new
		@purchase_order.purchase_items.build
		@purchase_order.supplier = Supplier.new
		@purchase_order.shipping_and_handling = 0;
		@purchase_order.other_charges = 0;
		@purchase_order.currency = 'Dolares'
		@purchase_order.opening_date = Time.now.to_date
	end

	def create
		@purchase_order = PurchaseOrder.create(purchase_order_params)
		redirect_to purchase_orders_path
	end

	def update 
		@purchase_order.update(purchase_order_params)
		redirect_to purchase_orders_path
	end

	def destroy
		@purchase_order.destroy
		redirect_to purchase_orders_path
	end

	def show
		if @purchase_order.language == 'English'
			I18n.locale = :en
		elsif @purchase_order.language == 'Español'
			I18n.locale = :es
		end

		respond_to do |format|
			format.html
			format.pdf do
				render :pdf => "PO#{@purchase_order.folio}",
					:template => "purchase_orders/show.pdf.haml",
					:layout => 'purchase_order.pdf',
					:disposition => 'attachment',
					:show_as_html => params[:debug]
			end
		end
	end

	private
	def set_purchase_order
		@purchase_order = PurchaseOrder.find(params[:id])
	end

	def purchase_order_params
		params.require(:purchase_order).permit(:purchase_company, :company, :special_notes, :language, :shipping_address_id, :shipping_and_handling, :other_charges, :shipping_number, :supplier_id, :contact_id, :user_id, :currency, :opening_date, :purchase_items_attributes => [:description, :price, :quantity, :part_number, :id])
	end

	
end
