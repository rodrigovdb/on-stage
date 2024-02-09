# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :band

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { scope: :band_id }
end
