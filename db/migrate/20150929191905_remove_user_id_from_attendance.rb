class RemoveUserIdFromAttendance < ActiveRecord::Migration
  def change
	  remove_column :attendances, :user_id
  end
end
