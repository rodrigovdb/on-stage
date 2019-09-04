class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :determine_layout

  def darken
    current_user.setting.update(darken: params[:darken] == 'on')

    referer = Rails.application.routes.recognize_path(request.referrer)

    redirect_to referer and return
  end

  def set_band
    @band = Band.find params[:band_id]
  end

  def determine_layout
    current_user ? 'application' : 'login'
  end
end
