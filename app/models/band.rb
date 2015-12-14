class Band < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  has_many  :band_users
  has_many  :users, through:  :band_users

  has_many  :songs
  has_many  :setlists

  validates :name,  presence: true, uniqueness: { scope: :owner, message: 'Banda já cadastrada' }

  def user_belongs?(user)
    !BandUser.where(band: self, user: user).first.nil?
  end
end
