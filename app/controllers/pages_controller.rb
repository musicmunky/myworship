class PagesController < ApplicationController
	def index
#		@schedules = Schedule.all.order("schedule_date DESC")
# 		@posts = Post.paginate(:page => params[:page], :per_page => 20)
		@schedules = Schedule.paginate(:page => params[:page], :per_page => 10).order("schedule_date DESC")
	end

	def reports
		@schedules = Schedule.all.order("schedule_date DESC")
		@songs = Song.all
	end
end
