# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :band

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { scope: :band_id }

  def track_duration=(string)
    self.duration = TrackDuration.new(string).seconds
  end

  def track_duration
    return unless duration

    TrackDuration.new(duration).to_s
  end
end
