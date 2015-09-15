class SchedulesController < ApplicationController
	before_action :set_schedule, only: [:show, :edit, :update, :destroy]

	# GET /schedules
	# GET /schedules.json
	def index
		@schedules = Schedule.all
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

		schdate = Date.strptime(schedule_params['schedule_date'], '%m/%d/%Y') #.strftime("%Y-%d-%m")
		songids = JSON.parse(params['song_ids'])
		params.delete('song_ids')
		params['schedule_date'] = schdate

		newschedule = { :name => params['name'], :schedule_date => schdate, :notes => params['notes']}

# 		logger.debug "\n\n\n\n\n\n\nSCHEDULE DATE IS: #{schdate}\n\n\n\n\n\n\n"

		@schedule = Schedule.new(newschedule)

		respond_to do |format|
			if @schedule.save

				@schedule.songs << Song.find(songids)

				format.html { redirect_to schedules_url, notice: 'Schedule was successfully created.' }
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
		songids = JSON.parse(params['song_ids'])
		params.delete('song_ids')
		params['schedule_date'] = schdate

# 		logger.debug "\n\n\n\n\n\n\nSCHEDULE DATE IS: #{schdate}\n\n\n\n\n\n\n"

		respond_to do |format|
			if @schedule.update(params)

				@schedule.songs = Song.find(songids)

				format.html { redirect_to schedules_url, notice: 'Schedule was successfully updated.' }
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
			format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:name, :schedule_date, :notes, :song_ids)
    end
end
