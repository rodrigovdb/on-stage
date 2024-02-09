# frozen_string_literal: true

class BandUser < ApplicationRecord
  belongs_to :band
  belongs_to :user

  validates :role, presence: true

  validates :role, uniqueness: { scope: :band_id, message: 'a band can has just one owner' }, if: :owner?

  enum role: { owner: 'owner', mate: 'mate' }
end
