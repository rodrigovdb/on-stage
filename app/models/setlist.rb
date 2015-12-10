class Setlist < ActiveRecord::Base
  belongs_to :band

  validates :name,  presence: true, uniqueness: { scope: :band, message: 'Setlist já cadastrado' }
end
