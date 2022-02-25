class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update, :destroy, :performance]
	def index
		@search = User.search do
			fulltext params[:search]
			paginate :page => params[:page], :per_page => 20
		end
		@employees = @search.results
	end

	def edit
		@action = 'edit'
	end

	def new
		@employee = User.new
		@employee.roles = []
		@action = 'create'
	end

	def create
		@employee = User.create(employee_params)
		roles = []
		if params[:clients] 
			roles.push(:clients)
		end
		if params[:opportunities] 
			roles.push(:opportunities)
		end
		if params[:products] 
			roles.push(:products)
		end
		if params[:requirements] 
			roles.push(:requirements)
		end
		if params[:suppliers] 
			roles.push(:suppliers)
		end
		if params[:purchase_orders] 
			roles.push(:purchase_orders)
		end
		if params[:shipping_addresses] 
			roles.push(:shipping_addresses)
		end
		if params[:users] 
			roles.push(:users)
		end
		if params[:update] 
			roles.push(:update)
		end
		if params[:destroy] 
			roles.push(:destroy)
		end
		@employee.roles = roles
		@employee.save
		redirect_to employees_path
	end

	def update
		@employee.update(employee_params.reject{|_, v| v.blank?})
		roles = []
		if params[:clients] 
			roles.push(:clients)
		end
		if params[:opportunities] 
			roles.push(:opportunities)
		end
		if params[:products] 
			roles.push(:products)
		end
		if params[:requirements] 
			roles.push(:requirements)
		end
		if params[:suppliers] 
			roles.push(:suppliers)
		end
		if params[:purchase_orders] 
			roles.push(:purchase_orders)
		end
		if params[:shipping_addresses] 
			roles.push(:shipping_addresses)
		end
		if params[:users] 
			roles.push(:users)
		end
		if params[:update] 
			roles.push(:update)
		end
		if params[:destroy] 
			roles.push(:destroy)
		end
		@employee.roles = roles
		@employee.save
		redirect_to employees_path
	end

	def destroy
		@employee.destroy
		redirect_to employees_path
	end

	def performance
		if params.has_key?(:start_date)
			@start_date = params[:start_date].to_date
		else
			@start_date = Date.today - 1.month
		end
		if params.has_key?(:end_date)
			@end_date = params[:end_date].to_date
		else
			@end_date = Date.today
		end
	end

	private
	def set_employee
		@employee = User.find(params[:id])
	end

	def employee_params
		params.require(:user).permit(:avatar, :first_name, :last_name, :organization, :position, :work_phone, :home_phone, :mobile_phone, :fax_number, :address, :city, :state, :zip_code, :country, :email, :website, :notes, :password, :password_confirmation, :admin)
	end
end
