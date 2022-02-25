class DocumentsController < ApplicationController
	before_action :set_document, only: [:show, :edit, :update, :destroy]

	def create
		@document = Document.create(document_params)
		if not @document.client.blank?
			redirect_to client_path(@document.client)
		else
			redirect_to supplier_path(@document.client)
		end
	end

	def destroy
		@document.destroy
		if not @document.client.blank?
			redirect_to client_path(@document.client)
		else
			redirect_to supplier_path(@document.client)
		end
	end

	private
	def set_document
		@document = Document.find(params[:id])
	end

	
	
	def document_params
		params.require(:document).permit(:client_id, :supplier_id, :content)
	end
end
