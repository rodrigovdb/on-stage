class BandUser < ApplicationRecord
  belongs_to  :band
  belongs_to  :user

  validates :user_id, uniqueness: { scope: :band_id }
end
