class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

    # GET /tags
    # GET /tags.json
    def index
        @tags = Tag.all
    end

    # GET /tags/1
    # GET /tags/1.json
    def show
        @songs = @tag.songs
    end

    # GET /tags/new
    def new
        @tag = Tag.new
    end

    # GET /tags/1/edit
    def edit
    end

    def getTagsByType

		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
            @aAllTags = Tag.all
            @aHashTags = []

            nSongId = params[:song_id].to_i

            @aAllTags.each do |tag|
				@aHashTags.push(tag.attributes)
			end

            @aSongTags = []
            if nSongId > 0
                oSong = Song.find(nSongId)
                @aSongTags = oSong.tags.pluck(:id)
            end

            @aAllTypes = Tag.select(:tag_type).distinct.map { |t| t.tag_type }

            #hash = Hash.new {|hash, key| hash[key] = f(key) }

            content['tags'] = @aHashTags
            content['types'] = @aAllTypes
            content['selected_tags'] = @aSongTags

            message = "All tags successfully loaded"

			response['status']  = "success"
			response['message'] = message
			response['content'] = content
		rescue => error
			response['status']  = "failure"
			response['message'] = "Error: #{error.message}"
			response['content'] = error.backtrace
		ensure
			respond_to do |format|
				format.html { render :json => response.to_json }
			end
		end
    end

    def addNewTagFromSong
        sNewTagName = params[:sNewTagName]
        sNewTagType = params[:sNewTagType]
		response = {}
		content  = {}
		status   = ""
		message  = ""

		begin
            @oExistingTag = Tag.where(name: sNewTagName, tag_type: sNewTagType).first

            if @oExistingTag.nil?
                @oNewTag = Tag.new
                @oNewTag.name = sNewTagName
                @oNewTag.tag_type = sNewTagType
                @oNewTag.save!

                content['tag_id'] = @oNewTag.id
                content['tag_name'] = @oNewTag.name
                content['tag_type'] = @oNewTag.tag_type
                content['tag_exists'] = false
                message = "Tag '#{@oNewTag.name}' added to the database!"
            else
                content['tag_id'] = @oExistingTag.id
                content['tag_name'] = @oExistingTag.name
                content['tag_type'] = @oExistingTag.tag_type
                content['tag_exists'] = true
                message = "Tag '#{@oExistingTag.name}' is already in the database!"
            end

			response['status'] = "success"
			response['message'] = message
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

    # POST /tags
    # POST /tags.json
    def create
        @tag = Tag.new(tag_params)

        respond_to do |format|
            if @tag.save
                format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
                format.json { render :show, status: :created, location: @tag }
            else
                format.html { render :new }
                format.json { render json: @tag.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /tags/1
    # PATCH/PUT /tags/1.json
    def update
        respond_to do |format|
            if @tag.update(tag_params)
                format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
                format.json { render :show, status: :ok, location: @tag }
            else
                format.html { render :edit }
                format.json { render json: @tag.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /tags/1
    # DELETE /tags/1.json
    def destroy
        @tag.destroy
        respond_to do |format|
            format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
            format.json { head :no_content }
        end
    end


    private
        # Use callbacks to share common setup or constraints between actions.
        def set_tag
            @tag = Tag.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def tag_params
            params.require(:tag).permit(:name, :tag_type)
        end
end
