class Reminder < ActiveRecord::Base
	belongs_to :user
	belongs_to :user_assigning, :class_name => "User", foreign_key: 'user_assigning_id'
end
