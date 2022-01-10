class BandUsersController < ApplicationController
  before_action :set_band

  # GET /band_users or /band_users.json
  def index
    # format.turbo_stream
  end

  # GET /band_users/new
  def new
    @band_user = BandUser.new(band: @band)
  end


  # POST /band_users or /band_users.json
  def create
    user = User.find_by(email: band_user_params[:email])
    @band_user = BandUser.new(user: user, band: @band)

    respond_to do |format|
      if @band_user.save
        format.turbo_stream
        format.html { redirect_to band_user_url(@band_user), notice: "Band user was successfully created." }
        format.json { render :show, status: :created, location: @band_user }
      else
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @band_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /band_users/1 or /band_users/1.json
  def destroy
    @band_user.destroy

    respond_to do |format|
      format.html { redirect_to band_users_url, notice: "Band user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @band = Band.find(params[:band_id])
  end

  # Only allow a list of trusted parameters through.
  def band_user_params
    params.fetch(:band_user).permit(:email)
  end
end
