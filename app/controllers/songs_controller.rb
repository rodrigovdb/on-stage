class SongsController < ApplicationController
  before_action :set_band
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /songs or /songs.json
  def index
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new(band: @band)
  end

  # GET /songs/1/edit
  def edit
    render :new
  end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params.merge(band: @band))

    respond_to do |format|
      if @song.save
        format.turbo_stream
        format.html { redirect_to song_url(@song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.turbo_stream
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.turbo_stream
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = @band.songs.find_by(id: params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @band = Band.find(params[:band_id])
  end

  # Only allow a list of trusted parameters through.
  def song_params
    params.require(:song).permit(:band_id, :name, :artist, :key, :duration, :chords)
  end
end
