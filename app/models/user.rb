class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:rememberable, :trackable, :validatable #:recoverable,
	has_many :attendances

	def get_name
		fullname = "#{self.first_name} #{self.last_name}"
	end

	def get_first_name
		self.first_name
	end

end
