# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :band

  has_many :setlist_songs, dependent: :destroy
  has_many :setlists, through: :setlist_songs

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { scope: :band_id }

  def track_duration=(string)
    self.duration = TrackDuration.new(string).seconds
  end

  def track_duration
    return unless duration

    TrackDuration.new(duration).to_s
  end

  def to_s
    "#{name} (#{artist})"
  end
end
