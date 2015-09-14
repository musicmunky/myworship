class CreateSongSchedule < ActiveRecord::Migration
  def change
    create_table :schedules_songs, :id => false do |t|
	t.belongs_to :song, index: true
	t.belongs_to :schedule, index: true
    end
  end
end
