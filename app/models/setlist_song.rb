# frozen_string_literal: true

class SetlistSong < ApplicationRecord
  belongs_to :setlist
  belongs_to :song

  validates :song, uniqueness: { scope: :setlist, message: 'is already in the setlist'}

  before_create :set_display_sort

  private

  def set_display_sort
    self.display_sort = setlist.setlist_songs.maximum(:display_sort).to_i + 1
  end
end
