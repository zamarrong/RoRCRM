class ClientsController < ApplicationController
	before_action :set_client, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource
	
	def index
		@headers = {
			:client_name => :desc,
			:state => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :client_name
		direction = params[:direction] || :asc

		if params.has_key?(:per_page)
			cookies[:per_page] = params[:per_page]
		end

		if cookies[:per_page].nil?
			cookies[:per_page] = 25
		end

		@search = Client.search(:include => [:contacts]) do
			fulltext params[:search]
			with(:state, params[:state]) if !params[:state].nil?
			paginate :page => params[:page], :per_page => cookies[:per_page]
			order_by order, direction
		end

		@clients = @search.results

		respond_to do |format|
			format.html
			format.json { render json: Client.all.map{ |c| c.name } }
			format.xlsx { render xlsx: 'clients',filename: "clientes.xlsx"}
		end
	end

	def search
		client = Client.where(name: params[:q]).first
		respond_to do |format|
			format.json { render json: {:id => client.id, :contacts => client.contacts.map{ |c| {:id => c.id, :name => c.name} } } }
		end
	end

	def new
		@client = Client.new
		@client.country = "México"
		@client.contacts.build
	end

	def create
		@client = Client.new(client_params)
		if @client.save
			redirect_to client_path(@client)
		else
			redirect_to new_client_path(@client), :flash => { :alert => "Cliente duplicado"}
		end
	end

	def update
		@client.update(client_params)
		redirect_to client_path(@client)
	end

	def destroy
		@client.destroy
		redirect_to clients_path
	end

	def list
		@clients = Client.all.map{ |c| c.name } + Contact.all.map{ |c| c.name}
		render json: @clients
	end

	def import
		Client.import(params[:file])
		redirect_to clients_path
	end

	private
	def set_client
		@client = Client.find(params[:id])
	end

	def client_params
		params.require(:client).permit(:company, :avatar, :name, :address, :city, :state, :zip_code, :country, :website, :contacts_attributes => [:id, :name, :position, :telephone, :telephone_2, :email, :_destroy])
	end
end
