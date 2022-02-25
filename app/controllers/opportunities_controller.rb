class OpportunitiesController < ApplicationController
	before_action :set_opportunity, only: [:update, :edit, :destroy, :cotizacion]
	def index
		@headers = {
			:client => :desc,
			:user_name => :desc,
			:opening_date => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :created_at
		direction = params[:direction] || :desc
		@search = Opportunity.search(:include => [:client,:user]) do
			fulltext params[:search]
			order_by order, direction
			paginate :page => params[:page]
		end
		@opportunities = @search.results
	end

	def new
		@opportunity = Opportunity.new
		if params.has_key?(:client_id)
			@opportunity.client = Client.find(params[:client_id])
		end
		@opportunity.tax = 16.0
		@opportunity.currency = 'Dolares'
		@opportunity.opening_date = Time.now.to_date
		@opportunity.user = current_user
		@opportunity.quotes.build
	end

	def create
		@opportunity = Opportunity.create(opportunity_params)
		redirect_to opportunities_path
	end

	def update
		@opportunity.update(opportunity_params)
		redirect_to opportunities_path
	end

	def open
		@headers = {
			:client => :desc,
			:user_name => :desc,
			:opening_date => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :created_at
		direction = params[:direction] || :desc
		@search = Opportunity.search do
			fulltext params[:search]
			with(:closed, false)
			with(:due_date).greater_than_or_equal_to(Date.today)
			order_by order, direction
			paginate :page => params[:page]
		end
		@opportunities = @search.results
	end

	def expired
		@headers = {
			:client => :desc,
			:user_name => :desc,
			:opening_date => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :created_at
		direction = params[:direction] || :desc
		@search = Opportunity.search do
			fulltext params[:search]
			with(:closed, false)
			with(:due_date).less_than(Date.today)
			order_by order, direction
			paginate :page => params[:page]
		end
		@opportunities = @search.results
	end

	def closed
		@headers = {
			:client => :desc,
			:user_name => :desc,
			:opening_date => :desc
			}
		@headers[params[:order].to_sym] = params[:direction].to_sym if !params[:order].nil?

		order = params[:order] || :created_at
		direction = params[:direction] || :desc
		@search = Opportunity.search do
			fulltext params[:search]
			with(:closed, true)
			paginate :page => params[:page]
			order_by order, direction
		end
		@opportunities = @search.results
	end

	def destroy
		@opportunity.destroy
		redirect_to opportunities_path
	end

	def cotizacion
		respond_to do |format|
			format.html
			format.pdf do
				render :pdf => "Cotizacion#{@opportunity.full_folio}",
					:template => "opportunities/cotizacion.pdf.haml",
					:layout => 'cotizacion.pdf',
					:disposition => 'attachment',
					:show_as_html => params[:debug].present?
			end
		end
	end

	private

	def set_opportunity
		@opportunity = Opportunity.find(params[:id])
	end

	def opportunity_params
		params.require(:opportunity).permit(:company, :special_notes, :payment_conditions, :client_id, :contact_id, :user_id, :currency, :valuation, :how_was_it_found, :opening_date, :due_date, :tax, :price, :closed, :quotes_attributes => [:_destroy, :id, :description, :price, :quantity, :product_id, :image])
	end
end
