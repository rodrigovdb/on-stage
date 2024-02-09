# frozen_string_literal: true

class BandsController < ApplicationController
  include BandMember

  before_action :set_band, only: %i[show edit update destroy]
  before_action :ensure_band_member, except: %i[index new create]
  before_action :ensure_band_owner, only: %i[edit update destroy]

  # GET /bands or /bands.json
  def index
    @bands = current_user.bands.order(created_at: :desc)
  end

  # GET /bands/1 or /bands/1.json
  def show; end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit; end

  # POST /bands or /bands.json
  def create
    form = BandForm.new(band_params.merge(user: current_user))

    respond_to do |format|
      if form.save
        @band = form.band
        format.html { redirect_to band_url(form.band), notice: t('app.successfully_created', item: Band.model_name.human) }
        format.json { render :show, status: :created, location: form.band }
        format.turbo_stream
      else
        @band = form.band
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1 or /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to band_url(@band), notice: t('app.successfully_updated', item: Band.model_name.human) }
        format.json { render :show, status: :ok, location: @band }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1 or /bands/1.json
  def destroy
    @band.destroy

    respond_to do |format|
      format.html { redirect_to bands_url, notice: t('app.successfully_destroyed', item: Band.model_name.human) }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @band = Band.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def band_params
    params.require(:band).permit(:name)
  end
end
