class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_owner, only: [:edit, :destroy]

  # GET /bands
  # GET /bands.json
  def index
    @bands  = current_user.associate_bands
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands
  # POST /bands.json
  def create
    @band       = Band.new(band_params)
    @band.owner = current_user

    respond_to do |format|
      if @band.save
        current_user.bands << @band

        format.html { redirect_to bands_path, notice: 'Banda cadastrada com sucesso' }
        format.json { render :show, status: :created, location: @band }
      else
        format.html { render :new }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to bands_path, notice: 'Banda atualizada com sucesso' }
        format.json { render :show, status: :ok, location: @band }
      else
        format.html { render :edit }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band.destroy
    respond_to do |format|
      format.html { redirect_to bands_url, notice: 'Banda excluída com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    def check_owner
      redirect_to bands_path, flash: { error: 'Esta ação só é permitida ao criador da banda' } unless @band.owner == current_user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:user_id, :name)
    end
end
