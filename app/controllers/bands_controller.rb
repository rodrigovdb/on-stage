class BandsController < ApplicationController
  before_action :set_band, only: %i[show edit update destroy invite_people join_members remove_member]
  before_action :check_owner, only: %i[edit destroy invite_people join_members remove_member]

  # GET /bands or /bands.json
  def index
  end

  # GET /bands/1 or /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
    render :new
  end

  # POST /bands or /bands.json
  def create
    @band = Band.new(band_params.merge(owner: current_user))

    respond_to do |format|
      if @band.save
        current_user.bands << @band

        format.turbo_stream
        format.html { redirect_to bands_path, notice: "Band was successfully created." }
        format.json { render :show, status: :created, location: @band }
      else
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1 or /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.turbo_stream
        format.html { redirect_to bands_path, notice: "Band was successfully updated." }
        format.json { render :show, status: :ok, location: @band }
      else
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1 or /bands/1.json
  def destroy
    @band.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to bands_url, notice: "Band was successfully destroyed." }
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

  # Only allow a list of trusted parameters through.
  def band_params
    params.require(:band).permit(:user_id, :name)
  end

  def validate_insert_member(user)
    @errors = []
    @errors << "Usuário #{params[:email]} não existe" unless user
    @errors << "Usuário #{params[:email]} já faz parte da banda" if @band.users.include? user

    @errors
  end

  def validate_remove_member(user)
    @errors = []
    @errors << "Usuário não existe" unless user
    @errors << "Usuário #{user.email} não pertence à banda #{@band.name}" unless @band.users.include? user
    @errors << "Não é possível excluir o criador da banda" if @band.owner == user

    @errors
  end
end
