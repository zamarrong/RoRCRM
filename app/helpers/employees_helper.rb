module EmployeesHelper
	def avatar_image(employee)
		if employee.avatar.blank?
			image_tag 'avatar_blank.png'
		else
			image_tag employee.avatar
		end
	end

	def website_url(employee)
		if !employee.website.blank?
			if employee.website.start_with?('http://')
		  		return employee.website
		  	else
		  		return "http://" + employee.website
		  	end
		else
			return ''
		end
	end

	def employee_form_url(action, employee)
		if action == 'create'
			return url_for(:controller => 'employees', :action => 'create')
		else
			return url_for(:controller => 'employees', :id => employee.id, :action => 'update')
		end
	end
end
