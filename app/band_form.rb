# frozen_string_literal: true

class BandForm < ApplicationForm
  attribute :name, :string
  attribute :user, User

  attr_reader :band

  def save
    transaction do
      @band = Band.new(name:)
      band.band_users << BandUser.new(user:, role: 'owner')

      band.valid? && band.save!
    end
  end
end
