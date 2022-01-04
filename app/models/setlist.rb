class Setlist < ApplicationRecord
  belongs_to :band

  has_many :setlist_songs, dependent: :delete_all
  has_many :songs, through: :setlist_songs
  accepts_nested_attributes_for :setlist_songs, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, uniqueness: { scope: :band, message: 'Setlist já cadastrado' }

  after_save :fix_sort

  def fix_sort
    count = 1

    setlist_songs.order(:display_sort).each do |item|
      item.update display_sort: count
      count += 1
    end
  end

  def songs_sorted
    Song.joins(:setlist_songs)
        .where('setlist_songs.setlist_id = ?', id)
        .order('setlist_songs.display_sort')
  end

  def first_song
    songs_sorted.first
  end

  def last_song
    songs.joins(:setlist_songs).order('setlist_songs.display_sort DESC').first
  end

  def duration
    songs.sum(:duration)
  end

  def to_s
    response  = name
    response += "(#{date.strftime('%d/%m/%Y')})" unless date.blank?

    response
  end
end
