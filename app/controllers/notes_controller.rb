class NotesController < ApplicationController
	before_action :set_note, only: [:show, :edit, :update, :destroy]
	before_action :set_parent, only: [:new, :create]

	def new
		@note = @parent.notes.build
	end

	def create
		@note = Note.create(note_params)
		if not @note.client.blank?		
			redirect_to client_path(@parent)
		else
			redirect_to supplier_path(@parent)
		end

	end

	def update
		@note.update(note_params)
		if not @note.client.blank?		
			redirect_to client_path(@parent)
		else
			redirect_to supplier_path(@parent)
		end
	end

	def destroy
		@note.destroy
		if not @note.client.blank?		
			redirect_to client_path(@parent)
		else
			redirect_to supplier_path(@parent)
		end
	end

	private
	def set_note 
		@note = Note.find(params[:id])
	end

	def set_parent
		if params[:parent] == "supplier"
			@parent = Supplier.find(params[:supplier_id])
		elsif params[:parent] == "client"
			@parent = Client.find(params[:client_id])
		end
	end

	def note_params
		params.require(:note).permit(:client_id, :supplier_id, :date, :content, :user_id)
	end
end
