class Comment < ActiveRecord::Base

	include ActsAsCommentable::Comment

	belongs_to :commentable, :polymorphic => true

	default_scope -> { order('created_at ASC') }

	# NOTE: install the acts_as_votable plugin if you
	# want user to vote on the quality of comments.
	#acts_as_voteable

	# NOTE: Comments belong to a user
	belongs_to :user


	def get_comment_user_info
		cmnt_info = {}
		user = User.find(self.user_id)
		cmnt_info['user_name'] = user.get_name
		cmnt_info['user_email'] = user.email
		cmnt_info['user_id'] = user.id
		return cmnt_info
	end
end
