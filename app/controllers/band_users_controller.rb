# frozen_string_literal: true

class BandUsersController < ApplicationController
  include BandMember

  before_action :set_band
  before_action :set_band_user, only: %i[show edit update destroy]
  before_action :ensure_band_member, except: %i[index show]
  before_action :ensure_band_owner, only: %i[destroy transfer_ownership]

  # GET /band_users or /band_users.json
  def index
    @band_users = @band.band_users.order({ role: :desc, created_at: :asc }).includes(:user)
  end

  # GET /band_users/1 or /band_users/1.json
  def show; end

  # GET /band_users/new
  def new
    @band_user = BandUser.new(band: @band)
  end

  # POST /band_users or /band_users.json
  def create
    form = BandUserForm.new(band_user_params.merge(band: @band, role: :mate))

    respond_to do |format|
      if form.save
        @band_user = form.band_user
        format.html { redirect_to band_user_url(@band_user), notice: t('app.successfully_created', item: BandUser.model_name.human) }
        format.json { render :show, status: :created, location: @band_user }
        format.turbo_stream
      else
        @band_user = form.band_user
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @band_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /band_users/1 or /band_users/1.json
  def destroy
    @band_user.destroy

    respond_to do |format|
      format.html { redirect_to band_band_users_url, notice: t('app.successfully_destroyed', item: BandUser.model_name.human) }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  def transfer_ownership
    form = TransferBandOwnershipForm.new(band: @band, band_user: @band.band_users.find(params[:id]))

    respond_to do |format|
      if form.save
        format.html { redirect_to @band, notice: t('app.ownership_successfully_transfered') }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_band_user
    @band_user = @band.band_users.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def band_user_params
    params.require(:band_user).permit(:email)
  end
end
