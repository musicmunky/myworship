class CreateSongSongKey < ActiveRecord::Migration
  def change
    create_table :song_song_keys, :id => false do |t|
		t.belongs_to :song, index: true
		t.belongs_to :song_key, index: true
    end
  end
end
