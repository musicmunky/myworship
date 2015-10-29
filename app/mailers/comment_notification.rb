class CommentNotification < ApplicationMailer
	default from: "noreply@ffcsongs.com"
	layout 'mailer'


	def send_comment_notification(user)
		@user = user
		mail(to: @user.email, subject: 'Sample Email')
	end

end
