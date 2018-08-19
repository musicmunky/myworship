class Song < ActiveRecord::Base

	include ActionView::Helpers::TagHelper

	acts_as_commentable

	has_and_belongs_to_many :schedules
	has_and_belongs_to_many :song_keys
	has_and_belongs_to_many :tags


	def get_embed_video
		begin
			mtch = self.media_link.match(/.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/)
			vid  = mtch.length > 0 ? content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{mtch[1]}", style: "width:500px;height:300px;border:none;") : ""
		rescue
			vid = ""
		ensure
			return vid
		end
	end


	def get_last_scheduled_span
		schdl_date = ""
		schdl = self.schedules.order("schedule_date DESC").first

		if !schdl.nil?
			diff = (Time.now().to_date - schdl.schedule_date).to_i
			schdl_date = schdl.schedule_date.strftime("%m/%d/%Y")

			ttlstr = "#{diff} days"
			if diff < 0
				ttlstr = "Future Schedule"
			end

			if diff > 60
				last_date = "<span class='label label-success' title=\"#{ttlstr}\">#{schdl_date}</span>"
			elsif diff > 30
				last_date = "<span class='label label-warning' title=\"#{ttlstr}\">#{schdl_date}</span>"
			else
				last_date = "<span class='label label-danger' title=\"#{ttlstr}\">#{schdl_date}</span>"
			end
		else
			last_date = "<span class='label label-default' title='Never Scheduled'>N/A</span>"
		end
		return last_date
	end


	def get_first_scheduled
		schdl_date = ""
		schdl = self.schedules.order("schedule_date ASC").first

		if !schdl.nil?
			schdl_date = schdl.schedule_date.strftime("%m/%d/%Y")
		else
			schdl_date = "N/A"
		end
		return schdl_date
	end


	def get_last_scheduled
		schdl_date = ""
		schdl = self.schedules.order("schedule_date DESC").first

		if !schdl.nil?
			schdl_date = schdl.schedule_date.strftime("%m/%d/%Y")
		else
			schdl_date = "N/A"
		end
		return schdl_date
	end


	def self.get_top_songs(lim, ascdsc)
		@connection = ActiveRecord::Base.connection
		songs = []
		songarray = []

		if ascdsc == "DESC"
			result = @connection.exec_query("SELECT `song_id`, COUNT(`song_id`) AS `num_schedules`
											 FROM `schedules_songs` GROUP BY `song_id`
											 ORDER BY `num_schedules` #{ascdsc} LIMIT #{lim};")
			result.each do |row|
				@song = Song.find(row['song_id'])
				songs.push([@song, row['num_schedules']])
			end

		else

			result = @connection.exec_query("SELECT id, name FROM songs
											 WHERE id NOT IN (SELECT DISTINCT song_id FROM schedules_songs)")
			diff = lim - result.length
			result.each do |row|
				@song = Song.find(row['id'])
				songs.push([@song, 0])
			end

			if diff > 0
				songarray = @connection.exec_query("SELECT `song_id`, COUNT(`song_id`) AS `num_schedules`
											 	 	FROM `schedules_songs` GROUP BY `song_id`
											 	 	ORDER BY `num_schedules` #{ascdsc} LIMIT #{diff};")
				songarray.each do |row|
					@song = Song.find(row['song_id'])
					songs.push([@song, row['num_schedules']])
				end
			else
				songs = songs[0..lim-1]
			end
		end

		return songs
	end
end
