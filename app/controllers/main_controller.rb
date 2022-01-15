class MainController < ApplicationController
  def index
  end

  def clear_message
    respond_to do |format|
      format.turbo_stream
    end
  end
end
