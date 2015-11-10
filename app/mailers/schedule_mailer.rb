class ScheduleMailer < ApplicationMailer
	default from: "administrator@ffcsongs.com"

	def weekly_schedule(sked)
		@sked = sked
		@url  = 'http://ffcsongs.com'

		sbjct = "Upcoming worship schedule for Faith Family Church - #{@sked.schedule_date.strftime('%m/%d/%Y')}"
#		email = "tim.w.andrews@gmail.com"
#		email = "randallbcotter@gmail.com"
		email = "ffcworshipministry@googlegroups.com"

		mail(to: email, subject: sbjct)
	end
end
