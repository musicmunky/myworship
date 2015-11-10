class PasswordResetMailer < ApplicationMailer
	default from: "administrator@ffcsongs.com"

	def password_reset_email(user, pass)
		@user = user
		@pass = pass
		@url  = 'http://ffcsongs.com'
		mail(to: @user.email, subject: 'Your FFC Songs account password has been reset')
#		mail(to: "tim.w.andrews@gmail.com", subject: 'Your FFC Songs account password has been reset')
	end
end
