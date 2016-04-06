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

    if @setlist.save
      redirect_to band_setlists_path(@band), notice: 'Setlist cadastrado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /setlists/1
  # PATCH/PUT /setlists/1.json
  def update
    if @setlist.update(setlist_params)
      redirect_to band_setlists_path(@band), notice: 'Setlist atualizado com sucesso.'
    else
      render :edit
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

  def copy
    @band         = Band.find params[:band_id]
    base_setlist  = Setlist.find params[:id]
    @setlist      = Setlist.new band: @band

    copy_setlist base_setlist

    if @setlist.save
      redirect_to band_setlist_path(@band, @setlist), notice: 'Setlist copiado com sucesso.'
    else
      render :edit
    end
  end

  private

  def copy_setlist(base_setlist)
    @setlist.name = params[:name].blank? ? 'Novo setlist (nome não informado)' : params[:name]
    base_setlist.songs_sorted.each { |song| @setlist.songs << song }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_setlist
    @setlist = Setlist.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def setlist_params
    params.require(:setlist).permit(:band_id, :name, :date, :notes, setlist_songs_attributes: [:id, :song_id, :_destroy])
  end
end
