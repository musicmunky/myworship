class PagesController < ApplicationController
	def index
		@schedules = Schedule.all
	end

	def reports
		@schedules = Schedule.all
		@songs = Song.all
	end
end
