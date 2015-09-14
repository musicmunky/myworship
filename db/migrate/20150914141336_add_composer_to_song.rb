class AddComposerToSong < ActiveRecord::Migration
  def change
	  add_column :songs, :composer, :string
  end
end
