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
			@users = User.order("last_name ASC")
		end
	end


	def updateUserInfo

		uid = params[:user_id]
		adm = params[:user_req_update]
		dat = params[:field_data]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@admn = User.find(adm)
			if !@admn.has_role? :admin
				msg = "INSUFFICIENT PRIVILEGES ERROR"
				logger.debug "\n\n#{msg}\n\n"
				raise msg
			end

			@user = User.find(uid)

			dat.each do |key, value|
				@user.update_attribute(key.to_sym, value)
			end

			response['status'] = "success"
			response['message'] = "Updated user information for #{@user.get_name}"
			response['content'] = content
		rescue => error
			response['status'] = "failure"
			response['message'] = "Error: #{error.message}"
			response['content'] = "User with insufficient privileges attempted to update attributes of another user"
# 			response['content'] = error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
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


	def resetPassword
		uid = params[:user_id]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@user = User.find(uid)

 			@pass = Devise.friendly_token.first(10)
 			@user.password = @pass
 			@user.password_confirmation = @pass
 			if @user.save
 				PasswordResetMailer.password_reset_email(@user, @pass).deliver_now
 			end

			response['status'] = "success"
			response['message'] = "Password reset for #{@user.get_name}"
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
