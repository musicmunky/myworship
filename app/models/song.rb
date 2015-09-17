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
		last_date = "N/A"
		if !self.schedules.order("schedule_date DESC").first.nil?
			last_date = self.schedules.order("schedule_date DESC").first.schedule_date.strftime("%m/%d/%Y")
		end
		return last_date
	end
end
