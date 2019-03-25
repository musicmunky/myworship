class AddScheduleTypeToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :schedule_type, :string
  end
end
