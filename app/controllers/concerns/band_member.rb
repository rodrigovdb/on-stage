# frozen_string_literal: true

module BandMember
  extend ActiveSupport::Concern

  def ensure_band_member
    return if @band.users.include?(current_user)

    redirect_to band_band_users_url,
                notice: "You don't have privileges to perform this action."
  end

  def ensure_band_owner
    return if @band.owner == current_user

    redirect_to band_band_users_url,
                notice: "You don't have privileges to perform this action."
  end
end
