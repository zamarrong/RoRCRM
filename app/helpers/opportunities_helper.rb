module OpportunitiesHelper
	def contact_options(opportunity)
		if opportunity.client.nil?
			return ''
		else
			return opportunity.client.contacts.map{ |c| [c.name, c.id] }
		end
	end
end
