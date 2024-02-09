# frozen_string_literal: true

class SongsController < ApplicationController
  include BandMember

  before_action :set_band
  before_action :set_song, only: %i[show edit update destroy]

  before_action :ensure_band_member, except: %i[index show]

  # GET /songs or /songs.json
  def index
    @songs = @band.songs.all.order(:name)
  end

  # GET /songs/1 or /songs/1.json
  def show; end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit; end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params.merge(band: @band))

    respond_to do |format|
      if @song.save
        format.html { redirect_to band_songs_url(@band, @song),  notice: t('app.successfully_created', item: Song.model_name.human) }
        format.json { render :show, status: :created, location: @song }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: t('app.successfully_updated', item: Song.model_name.human) }
        format.json { render :show, status: :ok, location: @song }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def song_params
    params.require(:song).permit(:name, :artist, :key, :duration, :chords)
  end
end
