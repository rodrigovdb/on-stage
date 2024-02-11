# frozen_string_literal: true

class Setlist < ApplicationRecord
  belongs_to :band

  has_many :setlist_songs, dependent: :destroy
  has_many :songs, through: :setlist_songs

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
