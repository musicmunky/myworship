class ChangeAttendanceUsersToAttendancesUsers < ActiveRecord::Migration

	def change
		rename_table :attendance_users, :attendances_users
	end

end
