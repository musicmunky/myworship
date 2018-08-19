class DropSongsTagsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :songs_tags
  end
end
