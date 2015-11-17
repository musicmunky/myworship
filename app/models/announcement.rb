class Announcement < ActiveRecord::Base
	belongs_to :user
	belongs_to :announcement_type

	def self.get_active
		@active_announcements = Announcement.where("is_active = true")
	end

	def self.get_active_by_type
		@active_announcements_by_type = Announcement.get_active.group_by { |a| a.announcement_type.type_name }
	end

end
