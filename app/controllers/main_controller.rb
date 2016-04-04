class MainController < ApplicationController
  before_action :authenticate_user!

  def index
    @bands    = current_user.associate_bands.includes(:users).order('id asc').limit(10)
    @setlists = Setlist.joins(:band).where('bands.user_id = ?', current_user.id).order('date desc').includes(:songs)
  end
end
