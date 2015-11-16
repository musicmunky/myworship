class AddNotificationMethodToNotification < ActiveRecord::Migration

	def change
		add_column :notifications, :notification_method, :string, :default => "EMAIL"
	end

end
