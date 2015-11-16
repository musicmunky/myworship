class NotificationsController < ApplicationController

	def index
	end

	def updateAdminNotify

		uid = params[:user_id]
		act = params[:is_active]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin

			@admn = User.find(uid)
			if !@admn.has_role? :admin
				msg = "INSUFFICIENT PRIVILEGES ERROR"
				logger.debug "\n\n#{msg}\n\n"
				raise msg
			end

			@ntfy = Notification.where("user_id = #{uid} and notification_type = 'COMMENT' and notification_method='EMAIL'")
			chk = act == "true" ? true : false;

			if @ntfy.size > 0
				@ntfy.first.update_attribute(:is_active, chk)
			else
				@ntfy = Notification.new({ notification_type: "COMMENT", notification_method: "EMAIL", user_id: uid, is_active: chk })
				@ntfy.save
			end

			response['status'] = "success"
			response['message'] = "Updated notification settings for #{@admn.get_name}"
			response['content'] = content
		rescue => error
			response['status'] = "failure"
			response['message'] = "Error: #{error.message}"
			response['content'] = "User with insufficient privileges attempted to update attributes of another user"
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end

	end

end
