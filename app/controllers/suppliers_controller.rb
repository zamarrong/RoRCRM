class SuppliersController < ApplicationController
	before_action :set_supplier, only: [:show, :edit, :update, :destroy]
	def index
		@headers = {
			:supplier_name => :desc,
			:state => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :supplier_name
		direction = params[:direction] || :asc

		if params.has_key?(:per_page)
			cookies[:per_page] = params[:per_page]
		end

		if cookies[:per_page].nil?
			cookies[:per_page] = 25
		end

		@search = Supplier.search(:include => [:contacts]) do
			fulltext params[:search]
			with(:state, params[:state]) if !params[:state].nil?
			paginate :page => params[:page], :per_page => cookies[:per_page]
			order_by order, direction
		end

		@suppliers = @search.results

		respond_to do |format|
			format.html
			format.json { render json: Supplier.all.map{ |c| c.name } }
			format.xlsx { render xlsx: 'clients',filename: "clientes.xlsx"}
		end
	end

	def search
		supplier = Supplier.where(name: params[:q]).first
		respond_to do |format|
			format.json { render json: {:id => supplier.id, :contacts => supplier.contacts.map{ |c| {:id => c.id, :name => c.name} } } }
		end
	end

	def new
		@supplier = Supplier.new
		@supplier.country = "México"
		@supplier.contacts.build
	end

	def create
		@supplier = Supplier.new(supplier_params)
		if @supplier.save
			redirect_to supplier_path(@supplier)
		else
			redirect_to new_supplier_path(@supplier), :flash => { :alert => "Proveedor duplicado"}
		end
	end

	def update
		@supplier.update(supplier_params)
		redirect_to supplier_path(@supplier)
	end

	def destroy
		@supplier.destroy
		redirect_to suppliers_path
	end

	def list
		@suppliers = Supplier.all.map{ |c| c.name }
		render json: @suppliers
	end

	def import
		Supplier.import(params[:file])
		redirect_to suppliers_path
	end

	private
	def set_supplier
		@supplier = Supplier.find(params[:id])
	end

	def supplier_params
		params.require(:supplier).permit(:terms, :company, :avatar, :name, :address, :city, :state, :zip_code, :country, :website, :contacts_attributes => [:id, :name, :position, :telephone, :telephone_2, :email, :_destroy])
	end
end

