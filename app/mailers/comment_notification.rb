class CommentNotification < ApplicationMailer
	default from: "noreply@ffcsongs.com"
	layout 'mailer'


	def comment_notification(user, comment)
		@user = user
		@comment = comment
		@url  = "http://ffcsongs.com"
		@emails = CommentNotification.get_admin_comment_email_list
		if @emails.size > 0
			mail(to: @emails, subject: 'FFCSONGS: New Comment Notification')
		end
	end

	def self.get_admin_comment_email_list
		emails = User.find(Notification.where("notification_type='COMMENT' and notification_method='EMAIL'").map(&:user_id)).map(&:email)
	end

end
