class SwapSongSortService < ApplicationService
  def initialize(setlist_song:, to_position:)
    @setlist_song = setlist_song
    @to_position = to_position
  end

  def call
    ActiveRecord::Base.transaction do
      current_setlist_song.update!(display_sort: setlist_song.display_sort)
      setlist_song.update!(display_sort: to_position)
    end
  end

  delegate :setlist, to: :setlist_song

  private

  attr_reader :setlist_song, :to_position

  def current_setlist_song
    @current_setlist_song ||= setlist.setlist_songs.find_by(display_sort: to_position)
  end
end
