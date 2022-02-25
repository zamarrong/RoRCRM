class RemindersController < ApplicationController
	before_action :set_reminder, only: [:show, :edit, :update, :destroy]

	def new
		@reminder = Reminder.new
		@reminder.user = User.find(params[:employee_id])
	end
	
	def create
		@reminder = Reminder.create(reminder_params)
		redirect_to employee_path(@reminder.user)
	end

	def edit

	end

	def destroy
		@reminder.destroy
		redirect_to employee_path(@reminder.user)
	end

	private
	def set_reminder
		@reminder = Reminder.find(params[:id])
	end

	
	
	def reminder_params
		params.require(:reminder).permit(:user_id, :text, :date, :user_assigning_id)
	end
end
