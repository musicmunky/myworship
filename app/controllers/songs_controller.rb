class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all.order(:name)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

	def getSongSchedules

		sid = params[:song_id]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@song = Song.find(sid)
			schedules = @song.schedules.order("schedule_date DESC")

			content['song_name'] = @song.name
			content['song_id']   = @song.id
			content['schedules'] = []

			c = 0
			schedules.each do |sch|
				content['schedules'].push(sch.attributes)
				c = c + 1
			end
			content['num_schedules'] = c

			response['status'] = "success"
			response['message'] = "Returning information on #{c} schedules for #{@song.name}"
			response['content'] = content
		rescue => error
			response['status'] = "failure"
			response['message'] = "Error: #{error.message}"
			response['content'] = error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end

	end


  # GET /songs/1/edit
  def edit
  end

	# POST /songs
	# POST /songs.json
	def create

		params = song_params
		songkey = params['song_key']
		params.delete('song_key')

		@song = Song.new(params)

		respond_to do |format|
			if @song.save

				if songkey.to_s.length > 0
					@song.song_keys << SongKey.find(songkey)
				end

				format.html { redirect_to songs_url, notice: 'Song was successfully created!' }
				format.json { render :show, status: :created, location: @song }
			else
				format.html { render :new }
				format.json { render json: @song.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /songs/1
	# PATCH/PUT /songs/1.json
	def update

		params = song_params
		songkey = params['song_key']
		params.delete('song_key')

		respond_to do |format|
			if @song.update(params)

				if songkey.to_s.length > 0
					@song.song_keys = [SongKey.find(songkey)]
				else
					@song.song_keys.destroy_all
				end
				format.html { redirect_to songs_url, notice: 'Song was successfully updated!' }
				format.json { render :show, status: :ok, location: @song }
			else
				format.html { render :edit }
				format.json { render json: @song.errors, status: :unprocessable_entity }
			end
		end
	end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :author, :capo_fret, :media_link, :lyrics, :composer, :song_key)
    end
end
