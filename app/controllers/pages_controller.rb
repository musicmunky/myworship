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


	def useradmin
		if current_user.nil? or !current_user.has_role? :admin
			respond_to do |format|
				format.html { redirect_to root_url, alert: 'You are not authorized to view that page' }
			end
		else
# 			@users = User.where("archive = false").order("last_name ASC")
			@users = User.order("last_name ASC")
		end
	end


	def updateAdmin
	end


	def deleteUser
	end

end
