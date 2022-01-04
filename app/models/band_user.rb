class BandUser < ApplicationRecord
  belongs_to  :band
  belongs_to  :user
end
