class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  layout :determine_layout

  private

  def determine_layout
    current_user ? 'application' : 'login'
  end
end
