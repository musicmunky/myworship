class TweetBuilder

	def get_tweet(t)

# https://dev.twitter.com/overview/api/entities
# Rails.logger.debug "ENT TYPE IS: #{ent[:ENT_TYPE]}, ENT IS: #{ent.to_s}"

		@tweet = t

		tweet_text = @tweet.text
		htags, users, links, media = [], [], [], []

		@tweet.hashtags.each do |htag|
			h = {}
			htag.instance_variables.each {|var| h[var.to_s.delete("@")] = htag.instance_variable_get(var) }
			htags.push(h['attrs'])
		end

		@tweet.user_mentions.each do |user|
			u = {}
			user.instance_variables.each {|var| u[var.to_s.delete("@")] = user.instance_variable_get(var) }
			users.push(u['attrs'])
		end

		@tweet.urls.each do |url|
			l = {}
			url.instance_variables.each {|var| l[var.to_s.delete("@")] = url.instance_variable_get(var) }
			links.push(l['attrs'])
		end

		@tweet.media.each do |med|
			m = {}
			med.instance_variables.each {|var| m[var.to_s.delete("@")] = med.instance_variable_get(var) }
			media.push(m['attrs'])
		end

		htags.each do |htag|
			htag[:ENT_TYPE] = "hashtag"
		end

		users.each do |user|
			user[:ENT_TYPE] = "user"
		end

		links.each do |link|
			link[:ENT_TYPE] = "link"
		end

		media.each do |meds|
			meds[:ENT_TYPE] = "media"
		end

		ents = htags + users + links + media
		ents_sorted = []
		if ents.length > 0
			ents_sorted = ents.sort_by { |hash| hash[:indices].first }.reverse
		end

		ents_sorted.each do |ent|
			tmp = ""
			indarry = ent[:indices]
			ind_beg = indarry[0]
			ind_end = indarry[1]
			s1 = tweet_text[0..ind_beg-1]
			s2 = tweet_text[ind_end+1..tweet_text.length]

			if !s1.nil? and s1.length > 0
				s1.strip!
			end
			if !s2.nil? and s2.length > 0
				s2.strip!
			end

			if ent[:ENT_TYPE] == "hashtag"
				tmp = "<a href='https://twitter.com/hashtag/#{ent[:text]}' target='_blank'>##{ent[:text]}</a>"
			elsif ent[:ENT_TYPE] == "user"
				tmp = "<a href='https://twitter.com/#{ent[:screen_name]}' target='_blank'>@#{ent[:screen_name]}</a>"
			elsif ent[:ENT_TYPE] == "link"
				tmp = "<a href='#{ent[:url]}' target='_blank'>#{ent[:url]}</a>"
			elsif ent[:ENT_TYPE] == "media"
				if ent[:type] == "photo"
					tmp = "<a href='#{ent[:url]}' target='_blank'><img src='#{ent[:media_url]}' style='width:90%;margin:5%;display:block;border-radius:2px;float:left;'/></a>"
				end
			end

			tweet_text = "#{s1} #{tmp} #{s2}"
		end

		return tweet_text

	end
end
