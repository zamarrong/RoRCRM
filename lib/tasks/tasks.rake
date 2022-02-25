task :update_closed_date => :environment do
	Opportunity.all.each do |opportunity|
		opportunity.update(:closed_date => opportunity.opening_date) if opportunity.closed?
	end
end

task :add_users_to_reminders => :environment do 
	Reminder.all.each do |reminder|
		reminder.update(:user_assigning_id => reminder.user_id)
	end
end