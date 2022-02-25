total = 0
total_closed = 0
json.data (@start_date..@end_date).each do |date|	
	total += Opportunity.where(opening_date: date, user_id: @employee.id).sum(:price)
	total_closed += Opportunity.where(closed_date: date, user_id: @employee.id, closed: true).sum(:price)
	json.array! [date, total, total_closed]
end
