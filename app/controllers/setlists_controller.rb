class SetlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_setlist, only: [:show, :edit, :update, :destroy, :play]
  before_action :set_band

  # GET /setlists
  # GET /setlists.json
  def index
    @setlists = @band.setlists.order([:date, :name]).includes(:songs)
  end

  # GET /setlists/1
  # GET /setlists/1.json
  def show
  end

  def play
    @setlist_song = SetlistSong.where(setlist: @setlist, song_id: params[:song_id]).first
    @song         = @setlist_song.song

    render layout: 'play'
  end

  # GET /setlists/new
  def new
    @setlist = Setlist.new
  end

  # GET /setlists/1/edit
  def edit
  end

  # POST /setlists
  # POST /setlists.json
  def create
    @setlist      = Setlist.new(setlist_params)
    @setlist.band = @band

    respond_to do |format|
      if @setlist.save
        format.html { redirect_to band_setlists_path(@band), notice: 'Setlist cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @setlist }
      else
        format.html { render :new }
        format.json { render json: @setlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /setlists/1
  # PATCH/PUT /setlists/1.json
  def update
    respond_to do |format|
      if @setlist.update(setlist_params)
        format.html { redirect_to band_setlists_path(@band), notice: 'Setlist atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @setlist }
      else
        format.html { render :edit }
        format.json { render json: @setlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setlists/1
  # DELETE /setlists/1.json
  def destroy
    @setlist.destroy
    respond_to do |format|
      format.html { redirect_to band_setlists_path(@band), notice: 'Setlist excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setlist
      @setlist = Setlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setlist_params
      params.require(:setlist).permit(:band_id, :name, :date, :notes, setlist_songs_attributes: [:id, :song_id, :_destroy])
    end
end
