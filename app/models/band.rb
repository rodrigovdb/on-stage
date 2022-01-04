class Band < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  has_many  :band_users, dependent: :delete_all
  has_many  :users, through: :band_users

  has_many  :songs,     dependent: :delete_all
  has_many  :setlists,  dependent: :delete_all

  validates :name, presence: true, uniqueness: { scope: :owner, message: 'Banda já cadastrada' }

  def user_belongs?(user)
    !BandUser.where(band: self, user: user).first.nil?
  end
end
