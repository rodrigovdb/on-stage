class Song < ActiveRecord::Base
  belongs_to :band

  validates :name,  presence: true, uniqueness: { scope: :band, message: 'Música já cadastrada' }
end
