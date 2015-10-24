class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

	# GET /announcements
	# GET /announcements.json
	def index
		if current_user.nil? or !current_user.has_role? :admin
			respond_to do |format|
				format.html { redirect_to root_url, alert: 'You are not authorized to view that page' }
			end
		else
			@announcements = Announcement.all
		end
	end

	# GET /announcements/1
	# GET /announcements/1.json
	def show
	end

	# GET /announcements/new
	def new
		if current_user.nil? or !current_user.has_role? :admin
			respond_to do |format|
				format.html { redirect_to root_url, alert: 'You are not authorized to view that page' }
			end
		else
			@announcement = Announcement.new
		end
	end

	# GET /announcements/1/edit
	def edit
		if current_user.nil? or !current_user.has_role? :admin
			respond_to do |format|
				format.html { redirect_to root_url, alert: 'You are not authorized to view that page' }
			end
		end
	end

	# POST /announcements
	# POST /announcements.json
	def create
		@announcement = Announcement.new(announcement_params)

		respond_to do |format|
			if @announcement.save
				format.html { redirect_to announcements_url, notice: 'Announcement was successfully created' }
				format.json { render :show, status: :created, location: @announcement }
			else
				format.html { render :new }
				format.json { render json: @announcement.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /announcements/1
	# PATCH/PUT /announcements/1.json
	def update
		respond_to do |format|
			if @announcement.update(announcement_params)
				format.html { redirect_to announcements_url, notice: 'Announcement was successfully updated' }
				format.json { render :show, status: :ok, location: @announcement }
			else
				format.html { render :edit }
				format.json { render json: @announcement.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /announcements/1
	# DELETE /announcements/1.json
	def destroy
		@announcement.destroy
		respond_to do |format|
			format.html { redirect_to announcements_url, notice: 'Announcement was successfully deleted' }
			format.json { head :no_content }
		end
	end


	def activeAnnouncement

		aid = params[:announcement_id]
		act = params[:is_active]

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
			@annc = Announcement.find(aid)
			@annc.update({is_active: act})

			response['status'] = "success"
			response['message'] = "Announcement updated successfully"
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:heading, :message, :is_active, :user_id)
    end
end
