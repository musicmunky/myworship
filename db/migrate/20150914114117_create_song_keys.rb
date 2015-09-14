class CreateSongKeys < ActiveRecord::Migration
  def change
    create_table :song_keys do |t|
      t.string :key_symbol
      t.string :key_full_name
      t.string :key_root
      t.string :key_modifier
      t.integer :capo_fret

      t.timestamps null: false
    end
  end
end
