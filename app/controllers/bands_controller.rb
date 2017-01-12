require "#{Rails.root}/lib/debug.rb"

class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy, :invite_people, :join_members, :remove_member]
  before_action :authenticate_user!
  before_action :check_owner, only: [:edit, :destroy, :invite_people, :join_members, :remove_member]

  # GET /bands
  # GET /bands.json
  def index
    @bands = current_user.associate_bands.includes(:users, :songs).order('name asc')
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
    @errors = []
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
  end

  def invite_people
  end

  def join_members
    user    = User.find_by_email params[:email]
    @errors = validate_insert_member(user)

    return unless @errors.empty?

    @band.users << user

    redirect_to band_path(@band), notice: 'Usuário adicionado com sucesso'
  end

  def remove_member
    user    = User.find params[:member]

    @errors = validate_remove_member(user)

    return render :show unless @errors.empty?

    item = BandUser.where(band: @band, user: user).first
    item.destroy

    redirect_to band_path(@band), notice: 'Usuário adicionado com sucesso'
  end

  # POST /bands
  # POST /bands.json
  def create
    @band       = Band.new(band_params)
    @band.owner = current_user

    if @band.save
      current_user.bands << @band

      redirect_to bands_path, notice: 'Banda cadastrada com sucesso'
    else
      render :new
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    if @band.update(band_params)
      redirect_to bands_path, notice: 'Banda atualizada com sucesso'
    else
      render :edit
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band.destroy

    redirect_to bands_url, notice: 'Banda excluída com sucesso'
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
