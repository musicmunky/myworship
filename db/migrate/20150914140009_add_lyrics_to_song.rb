class AddLyricsToSong < ActiveRecord::Migration
  def change
	add_column :songs, :lyrics, :text
  end
end
