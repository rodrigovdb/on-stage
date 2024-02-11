# frozen_string_literal: true

class SetlistsController < ApplicationController
  include BandMember

  before_action :set_band
  before_action :set_setlist, only: %i[show edit update destroy]

  before_action :ensure_band_member, except: %i[index show]

  # GET /setlists or /setlists.json
  def index
    @setlists = @band.setlists.all.order(:name)
  end

  # GET /setlists/1 or /setlists/1.json
  def show
    @songs = @setlist.songs.order(display_sort: :asc)
  end

  # GET /setlists/new
  def new
    @setlist = Setlist.new
  end

  # GET /setlists/1/edit
  def edit; end

  # POST /setlists or /setlists.json
  def create
    @setlist = Setlist.new(setlist_params.merge(band: @band))

    respond_to do |format|
      if @setlist.save
        format.html { redirect_to band_setlists_url(@band, @setlist),  notice: t('app.successfully_created', item: Setlist.model_name.human) }
        format.json { render :show, status: :created, location: @setlist }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /setlists/1 or /setlists/1.json
  def update
    respond_to do |format|
      if @setlist.update(setlist_params)
        format.html { redirect_to setlist_url(@setlist), notice: t('app.successfully_updated', item: Setlist.model_name.human) }
        format.json { render :show, status: :ok, location: @setlist }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setlists/1 or /setlists/1.json
  def destroy
    @setlist.destroy

    respond_to do |format|
      format.html { redirect_to setlists_url, notice: 'Setlist was successfully destroyed.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_setlist
    @setlist = Setlist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def setlist_params
    params.require(:setlist).permit(:name, :artist, :key, :duration, :chords)
  end
end
