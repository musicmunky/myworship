class SongKeysController < ApplicationController
  before_action :set_song_key, only: [:show, :edit, :update, :destroy]

  # GET /song_keys
  # GET /song_keys.json
  def index
    @song_keys = SongKey.all
  end

  # GET /song_keys/1
  # GET /song_keys/1.json
  def show
  end

  # GET /song_keys/new
  def new
    @song_key = SongKey.new
  end

  # GET /song_keys/1/edit
  def edit
  end

  # POST /song_keys
  # POST /song_keys.json
  def create
    @song_key = SongKey.new(song_key_params)

    respond_to do |format|
      if @song_key.save
        format.html { redirect_to @song_key, notice: 'Song key was successfully created.' }
        format.json { render :show, status: :created, location: @song_key }
      else
        format.html { render :new }
        format.json { render json: @song_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /song_keys/1
  # PATCH/PUT /song_keys/1.json
  def update
    respond_to do |format|
      if @song_key.update(song_key_params)
        format.html { redirect_to @song_key, notice: 'Song key was successfully updated.' }
        format.json { render :show, status: :ok, location: @song_key }
      else
        format.html { render :edit }
        format.json { render json: @song_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_keys/1
  # DELETE /song_keys/1.json
  def destroy
    @song_key.destroy
    respond_to do |format|
      format.html { redirect_to song_keys_url, notice: 'Song key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song_key
      @song_key = SongKey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_key_params
      params.require(:song_key).permit(:key_symbol, :key_full_name, :key_root, :key_modifier, :capo_fret)
    end
end
