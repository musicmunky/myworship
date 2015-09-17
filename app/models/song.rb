class Song < ActiveRecord::Base

	include ActionView::Helpers::TagHelper

	has_and_belongs_to_many :schedules
	has_and_belongs_to_many :song_keys

	def get_embed_video
		mtch = self.media_link.match(/.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/)
		vid  = mtch.length > 0 ? content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{mtch[1]}", style: "width:500px;height:300px;border:none;") : ""
		return vid
	end

	def get_last_scheduled
		schdl_date = ""
		schdl = self.schedules.order("schedule_date DESC").first

		if !schdl.nil?
			diff = (Time.now().to_date - schdl.schedule_date).to_i
			schdl_date = schdl.schedule_date.strftime("%m/%d/%Y")

			if diff > 60
				last_date = "<span class='label label-success' title=\"#{diff} days\">#{schdl_date}</span>"
			elsif diff > 30
				last_date = "<span class='label label-warning' title=\"#{diff} days\">#{schdl_date}</span>"
			else
				last_date = "<span class='label label-danger' title=\"#{diff} days\">#{schdl_date}</span>"
			end
		else
			last_date = "<span class='label label-default' title='Never Scheduled'>N/A</span>"
		end
		return last_date
	end
end
