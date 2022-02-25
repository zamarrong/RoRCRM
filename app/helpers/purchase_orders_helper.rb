module PurchaseOrdersHelper
	def contact_options_supplier(purchase_order)
		if purchase_order.supplier.nil?
			return ''
		else
			return purchase_order.supplier.contacts.map{ |c| [c.name, c.id] }
		end
	end
	def purchase_head_color(purchase_order)
		case purchase_order.company
		when 'Industrias Frimar'
			return 'dark-yellow'
		when 'Herramientas Frimar'
			return 'dark-red'
		when 'FMI'
			return 'dark-blue'
		end
	end
	def purchase_color(purchase_order)
		case purchase_order.company
		when 'Industrias Frimar'
			return 'yellow'
		when 'Herramientas Frimar'
			return 'red'
		when 'FMI'
			return 'blue'
		end
	end
end
