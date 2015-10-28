class CommentController < WebsocketRails::BaseController # < ApplicationController #

	def initialize_session
		# perform application setup here
		controller_store[:message_count] = 0
	end

	def index
	end

	def show
	end

	def new_comment
		# Here we call the rails-websocket broadcast_message method
#		broadcast_message :new_comment, message
		foo = "variable assignment"
		WebsocketRails.users[1].send_message('new_comment', {:message => 'NEW COMMENT'})
# 		WebsocketRails.users[1].send_message('new_comment', foo)
	end

end
