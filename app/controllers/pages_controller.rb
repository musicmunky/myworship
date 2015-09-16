class PagesController < ApplicationController
	def index
		@schedules = Schedule.all.order("schedule_date DESC")
	end

	def reports
		@schedules = Schedule.all.order("schedule_date DESC")
		@songs = Song.all
	end
end
