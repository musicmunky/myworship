class Schedule < ActiveRecord::Base
	has_and_belongs_to_many :songs
	serialize :song_order

	def get_songs_by_order
		@songs = !self.song_order.nil? ? Song.find(self.song_order.map(&:to_i)) : []
	end

end
