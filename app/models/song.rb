class Song < ActiveRecord::Base
	has_and_belongs_to_many :schedules
	has_and_belongs_to_many :song_keys
end
