class Schedule < ActiveRecord::Base
	has_and_belongs_to_many :songs
	acts_as_commentable
	serialize :song_order

	scope :next_schedule, Proc.new { |after = (DateTime.now + 5.hours), limit = 1| where('schedule_date > ?', after).order("schedule_date ASC").limit(limit) }

	def get_songs_by_order
		ids		= !self.song_order.nil? ? self.song_order.map(&:to_i) : []
		@songs	=  ids.length > 0 ? Song.find(ids).index_by(&:id).values_at(*ids) : []
		return @songs
	end

end
