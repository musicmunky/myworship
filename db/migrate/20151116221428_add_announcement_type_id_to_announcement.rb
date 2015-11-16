class AddAnnouncementTypeIdToAnnouncement < ActiveRecord::Migration
	def change
		add_column :announcements, :announcement_type_id, :integer
	end
end
