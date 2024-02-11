# frozen_string_literal: true

class TransferBandOwnershipForm < ApplicationForm
  attribute :band, Band
  attribute :band_user, BandUser

  def save
    transaction do
      band.band_users.update_all(role: :mate)
      band_user.update!(role: :owner)
    end
  end
end
