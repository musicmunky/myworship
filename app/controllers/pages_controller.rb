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

		uid = params[:user_id]
		adm = params[:is_admin]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@user = User.find(uid)

#  		logger.debug "\n\n\n\n\n\n\nADM IS: #{adm}\n\n\n\n\n\n\n"

			if adm == "true"
				@user.add_role(:admin)
			else
				@user.remove_role(:admin)
			end

			content['user'] = @user.attributes
			content['roles'] = @user.roles

			response['status'] = "success"
			response['message'] = "Updated role information for #{@user.get_name}"
			response['content'] = content
		rescue => error
			response['status'] = "failure"
			response['message'] = "Error: #{error.message}"
			response['content'] = error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end

	end


	def disableUser

		uid = params[:user_id]
		dis = params[:is_disabled]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@user = User.find(uid)

			arch = (dis == "true") ? true : false
			@user.update({archive: arch})

			content['user'] = @user.attributes

			response['status'] = "success"
			response['message'] = "Updated account information for #{@user.get_name}"
			response['content'] = content
		rescue => error
			response['status'] = "failure"
			response['message'] = "Error: #{error.message}"
			response['content'] = error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end

	end


	def deleteUser
	end

end
