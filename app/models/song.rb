class Song < ActiveRecord::Base
  belongs_to :band

  has_many :setlist_songs
  has_many :setlists, through: :setlist_songs

  validates :name,  presence: true, uniqueness: { scope: :band, message: 'Música já cadastrada' }

  def to_s
    response  = ""
    response += "#{artist} - " unless artist.nil?
    response += "#{name}"

    unless duration.blank?
      str = Time.at(duration).utc.strftime('%M:%S')

      response += " (#{str})"
    end

    response
  end
end
