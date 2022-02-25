class ContactsController < ApplicationController
	before_action :set_contact, only: [:show, :edit, :update, :destroy]
	before_action :set_parent, only: [:new, :create]

	def index
		respond_to do |format|
			format.json { render json: Contact.where(client_id: params[:client_id]).map{ |c| {:id => c.id, :name => c.name} } }
		end
	end
	
	def new
		@contact = @parent.contacts.build
	end

	def create
		@contact = Contact.create(contact_params)
		if not @contact.client.blank?		
			redirect_to client_path(@parent)
		else
			redirect_to supplier_path(@parent)
		end

	end

	def destroy
		@contact.destroy
		if not @contact.client.blank?		
			redirect_to client_path(@parent)
		else
			redirect_to supplier_path(@parent)
		end
	end

	def update
		@contact.update(contact_params)
		if not @contact.client.blank?		
			redirect_to client_path(@parent)
		else
			redirect_to supplier_path(@parent)
		end
	end

	private

	def set_parent
		if params[:parent] == "supplier"
			@parent = Supplier.find(params[:supplier_id])
		elsif params[:parent] == "client"
			@parent = Client.find(params[:client_id])
		end
	end

	def set_contact
		@contact = Contact.find(params[:id])
	end

	def contact_params
		params.require(:contact).permit(:name, :position, :telephone, :telephone_2, :email, :client_id, :supplier_id)
	end
end
