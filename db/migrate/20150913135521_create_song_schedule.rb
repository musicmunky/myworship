class CreateSongSchedule < ActiveRecord::Migration
  def change
    create_table :songs_schedules, :id => false do |t|
	t.belongs_to :song, index: true
	t.belongs_to :schedule, index: true
    end
  end
end
