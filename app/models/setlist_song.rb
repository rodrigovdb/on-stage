class SetlistSong < ActiveRecord::Base
  belongs_to :setlist
  belongs_to :song

  before_save :set_current_sort

  def set_current_sort
    last_item = SetlistSong.where(setlist: setlist).last
    sort      = last_item.nil? ? 0 : last_item.sort
    sort      = 0 if sort.nil?
    sort    += 1

    self.sort     = sort
  end
end
