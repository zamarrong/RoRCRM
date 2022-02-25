class PurchaseOrder < ActiveRecord::Base
	belongs_to :supplier
	belongs_to :contact
	belongs_to :user
	belongs_to :shipping_address

	before_create :set_folio

	has_many :purchase_items, dependent: :destroy
	accepts_nested_attributes_for :purchase_items, :allow_destroy => true

	searchable do
		text :supplier_name do
			supplier.name 
		end
		string :user_name do
			user.name
		end
		string :supplier do
			supplier.name
		end
		time :opening_date
		time :created_at
		integer :user_id
	end

	def set_folio
		self.folio = PurchaseOrder.maximum('folio').to_i + 1
	end

	def subtotal
		if not purchase_items.first.quantity.blank?
			purchase_items.inject(0) { |sum, q|  sum + (q.quantity * q.price) }
		else
			0
		end
	end

	def total
		subtotal + shipping_and_handling.to_f + other_charges.to_f
	end
	
end
