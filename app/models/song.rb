class Song < ActiveRecord::Base
  belongs_to :band

  has_many :setlist_songs
  has_many :setlists, through: :setlist_songs

  validates :name,  presence: true, uniqueness: { scope: :band, message: 'Música já cadastrada' }
end
