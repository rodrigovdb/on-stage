# frozen_string_literal: true

class SetlistSongsController < ApplicationController
  include BandMember

  before_action :set_band
  before_action :set_setlist
  before_action :set_setlist_song, only: %i[ show edit update destroy ]

  before_action :ensure_band_member

  # GET /setlist_songs or /setlist_songs.json
  def index
    @setlist_songs = SetlistSong.all
  end

  # GET /setlist_songs/1 or /setlist_songs/1.json
  def show
  end

  # GET /setlist_songs/new
  def new
    @setlist_song = SetlistSong.new
    @songs = @band.songs.where.not(id: @setlist.songs.map(&:id)).order(:name)
  end

  # POST /setlist_songs or /setlist_songs.json
  def create
    @setlist_song = SetlistSong.new(setlist_song_params.merge(setlist: @setlist))

    respond_to do |format|
      if @setlist_song.save
        format.html { redirect_to setlist_song_url(@setlist_song), notice: "Setlist song was successfully created." }
        format.json { render :show, status: :created, location: @setlist_song }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setlist_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setlist_songs/1 or /setlist_songs/1.json
  def destroy
    @setlist_song.destroy

    respond_to do |format|
      format.html { redirect_to setlist_songs_url, notice: "Setlist song was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def set_setlist
    @setlist = Setlist.find(params[:setlist_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_setlist_song
    @setlist_song = SetlistSong.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def setlist_song_params
    params.require(:setlist_song).permit(:song_id)
  end
end
