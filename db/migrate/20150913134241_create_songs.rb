class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :author
      t.string :song_key
      t.integer :capo_fret
      t.string :media_link

      t.timestamps null: false
    end
  end
end
