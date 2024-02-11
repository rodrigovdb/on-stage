# frozen_string_literal: true

class BandUserForm < ApplicationForm
  attribute :email, :string
  attribute :band, Band
  attribute :role, :string

  validates :email, presence: true
  validates :band, presence: true
  validates :role, presence: true

  attr_reader :band_user

  def save
    transaction do
      @band_user = band.band_users.new(user:, role:)

      band_user.valid? and band_user.save!
    end
  end

  private

  def user
    @user ||= User.where(email:).first_or_create do |user|
      user.password = 'password'
    end
  end
end
