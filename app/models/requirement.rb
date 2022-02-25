class Requirement < ActiveRecord::Base
	belongs_to :client
	belongs_to :user

	searchable do
		text :description
		text :budget
		text :client_name do
			client.name
		end
		text :employee_name do 
			user.name
		end
		time :created_at
	end
end
