class Opportunity < ActiveRecord::Base
	belongs_to :client
	belongs_to :user
	belongs_to :contact

	before_create :set_folio
	before_save :set_closed_date

	has_many :quotes, dependent: :destroy
	accepts_nested_attributes_for :quotes, :reject_if => :all_blank, :allow_destroy => true

	searchable do
		text :client_name do
			client.name 
		end
		string :user_name do
			user.name
		end
		string :client do
			client.name
		end
		text :title
		boolean :closed
		time :created_at
		time :opening_date
		time :due_date
		integer :user_id
	end

	def tax_amount
		t = tax || 0
		subtotal*(t/100)
	end

	def subtotal
		quotes.inject(0) { |sum, q|  sum + (q.quantity * q.price) }
	end

	def total
		subtotal + tax_amount
	end

	def full_folio
		if company == 'Herramientas Frimar'
			letter = 'H'
		else
			letter = 'F'
		end
		letter + created_at.strftime('%y') + folio.to_s.rjust(4, '0')
	end

	def set_folio
		self.folio = Opportunity.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year).maximum('folio').to_i + 1
	end

	def set_closed_date
		if self.closed_changed? and self.closed?
			self.closed_date = Date.today
		end
	end
	
end
