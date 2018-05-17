class Song < ActiveRecord::Base
  belongs_to :band

  paginates_per 10

  has_many :setlist_songs
  has_many :setlists, through: :setlist_songs

  validates :name, presence: true, uniqueness: { scope: :band, message: 'Música já cadastrada' }

  scope :term, -> (term) { where("name ILIKE ? or artist ILIKE ?", "%#{term}%", "%#{term}%") }

  def to_s
    response  = ''
    response += "#{artist} - " unless artist.nil?
    response += name

    response
  end

  def beauty_duration
    Time.at(duration).utc.strftime('%M:%S') unless duration.blank?
  end
end
