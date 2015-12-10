class Setlist < ActiveRecord::Base
  belongs_to :band

  has_many :setlist_songs
  has_many :songs, through: :setlist_songs
  accepts_nested_attributes_for :setlist_songs, reject_if: :all_blank, allow_destroy: true

  validates :name,  presence: true, uniqueness: { scope: :band, message: 'Setlist já cadastrado' }

  scope :songs_sort,  -> { joins(setlist_songs: [:song]).order('setlist_songs.order') }

  def add_song(song)
    last_song     = setlist_songs.order(:order).last
    current_sort  = last_song.nil? ? 1 : last_song.sort + 1
    setlist_songs << SetlistSong.new(sort: current_sort, song: song, setlist: self)
  end
end
