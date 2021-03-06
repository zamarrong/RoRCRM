module ApplicationHelper
	def link_to_remove_fields(name, f)
	   f.hidden_field(:_destroy) + link_to_function("<span class='glyphicon glyphicon-remove-sign'></span> #{name}".html_safe, "remove_fields(this)")
	end

	def link_to_add_fields(name, f, association)
	    new_object = f.object.class.reflect_on_association(association).klass.new
	    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
	      render(association.to_s.singularize + "_fields", :f => builder)
	    end
	    link_to_function("<span class='glyphicon glyphicon-plus-sign'></span> #{name}".html_safe, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
	end
end
