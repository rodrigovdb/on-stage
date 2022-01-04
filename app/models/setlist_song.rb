class SetlistSong < ApplicationRecord
  belongs_to :setlist
  belongs_to :song

  before_create :set_current_sort

  def set_current_sort
    last_item = SetlistSong.where(setlist: setlist).last
    display_sort  = last_item.nil? ? 0 : last_item.display_sort
    display_sort  = 0 if display_sort.nil?
    display_sort += 1

    self.display_sort = display_sort
  end

  def next
    SetlistSong.where(setlist: setlist, display_sort: display_sort + 1).first
  end

  def previous
    SetlistSong.where(setlist: setlist, display_sort: display_sort - 1).first
  end
end
