class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :opportunities, dependent: :destroy
  has_many :reminders

  serialize :roles

  	searchable do
		text :name
	end
         
  mount_uploader :avatar, AvatarUploader

  def name
  	first_name + ' ' + last_name
  end

  def open_opportunities
    opportunities.where(:closed=>false).count
  end

  def closed_opportunities
    opportunities.where(:closed=>true).count
  end

  def reminder_count
    reminders.where(:date=>Date.today).count
  end
end
