class Schedule < ActiveRecord::Base
	has_and_belongs_to_many :songs
	serialize :song_order

	def get_songs_by_order
		ids		= !self.song_order.nil? ? self.song_order.map(&:to_i) : []
		@songs	=  ids.length > 0 ? Song.find(ids).index_by(&:id).values_at(*ids) : []
		return @songs
	end

end
