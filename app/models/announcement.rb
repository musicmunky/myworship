class Announcement < ActiveRecord::Base
	belongs_to :user

	def self.get_active
		@active_announcements = Announcement.where("is_active = true")
	end
end
