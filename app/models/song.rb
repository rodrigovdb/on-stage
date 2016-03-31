class Song < ActiveRecord::Base
  belongs_to :band

  has_many :setlist_songs
  has_many :setlists, through: :setlist_songs

  validates :name,  presence: true, uniqueness: { scope: :band, message: 'Música já cadastrada' }

  def to_s
    response  = ""
    response += "#{artist} - " unless artist.nil?
    response += "#{name}"

    response
  end

  def beauty_duration
    unless duration.blank?
      Time.at(duration).utc.strftime('%M:%S')
    end
  end
end
