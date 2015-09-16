class AddSongOrderToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :song_order, :text
  end
end
