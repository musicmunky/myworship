class SchedulesController < ApplicationController # < WebsocketRails::BaseController #
	before_action :set_schedule, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, :except => [:show, :index]

	# GET /schedules
	# GET /schedules.json
	def index
		@schedules = Schedule.all.order("schedule_date DESC")
	end

	# GET /schedules/1
	# GET /schedules/1.json
	def show
	end

	# GET /schedules/new
	def new
		@schedule = Schedule.new
	end

	# GET /schedules/1/edit
	def edit
	end


	# POST /schedules
	# POST /schedules.json
	def create

		params  = schedule_params
		schdate = Date.strptime(schedule_params['schedule_date'], '%m/%d/%Y')
		songids = JSON.parse(params['song_order'])
		#params.delete('song_ids')
		params['schedule_date'] = schdate
		params['song_order'] = songids

		newschedule = { :name => params['name'], :schedule_date => schdate, :notes => params['notes'], :song_order => params['song_order']}
		@schedule = Schedule.new(newschedule)

		respond_to do |format|
			if @schedule.save

				@schedule.songs << Song.find(songids)

				format.html { redirect_to schedules_url, notice: 'Schedule was successfully created!' }
				format.json { render :show, status: :created, location: @schedule }
			else
				format.html { render :new }
				format.json { render json: @schedule.errors, status: :unprocessable_entity }
			end
		end
	end


	# PATCH/PUT /schedules/1
	# PATCH/PUT /schedules/1.json
	def update

		params  = schedule_params
		schdate = Date.strptime(schedule_params['schedule_date'], '%m/%d/%Y') #.strftime("%Y-%d-%m")
		songids = JSON.parse(params['song_order'])
		#params.delete('song_ids')
		params['schedule_date'] = schdate
		params['song_order'] = songids

# 		logger.debug "\n\n\n\n\n\n\nSCHEDULE DATE IS: #{schdate}\n\n\n\n\n\n\n"

		respond_to do |format|
			if @schedule.update(params)

				@schedule.songs = Song.find(songids)

				format.html { redirect_to schedules_url, notice: 'Schedule was successfully updated!' }
				format.json { render :show, status: :ok, location: @schedule }
			else
				format.html { render :edit }
				format.json { render json: @schedule.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /schedules/1
	# DELETE /schedules/1.json
	def destroy
		@schedule.destroy
		respond_to do |format|
			format.html { redirect_to schedules_url, notice: 'Schedule was successfully deleted!' }
			format.json { head :no_content }
		end
	end


	def addScheduleComment

		uid = params[:user_id]
		sid = params[:schedule_id]
		txt = params[:comment_text]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@schedule = Schedule.find(sid)

			comment = @schedule.comments.create
			comment.user_id = uid
			comment.comment = txt
			comment.save

			if comment.save
#				WebsocketRails[:comment].trigger(:new_comment, "THIS IS A TEST")
#				WebsocketRails.users[User.find(1).id].send_message :new_comment, "test foo"
				WebsocketRails[:comment].trigger(:new_comment, "true")
		    end

			content['user']		= comment.get_comment_user_info
			content['comment']	= comment.attributes

			response['status']	= "success"
			response['message']	= "Added comment for schedule id #{@schedule.id}"
			response['content']	= content
		rescue => error
			response['status']	= "failure"
			response['message']	= "Error: #{error.message}"
			response['content']	= error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end
	end


	def deleteScheduleComment

		cid = params[:comment_id]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			Comment.destroy(cid)
			content['comment_id'] = cid

			response['status']	= "success"
			response['message']	= "Removed comment"
			response['content']	= content
		rescue => error
			response['status']	= "failure"
			response['message']	= "Error: #{error.message}"
			response['content']	= error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:name, :schedule_date, :notes, :song_order)
    end
end
