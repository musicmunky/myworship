class PasswordResetMailer < ApplicationMailer
	default from: "admin@ffcsongs.com"

	def password_reset_email(user)
		@user = user
		@url  = 'http://www.ffcsongs.com'
#      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
		mail(to: "sixfivebeastman@yahoo.com", subject: 'Welcome to My Awesome Site')
	end
end
