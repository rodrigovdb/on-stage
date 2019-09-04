class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  has_one :setting

  has_many :band_leaders, class_name: 'Band'

  has_many :band_users
  has_many :bands, through: :band_users

  validates :email, uniqueness: true, presence: true

  def associate_bands
    Band.joins(:band_users).where('band_users.user_id = ?', id).order(:name)
  end

  def setting
    Setting.where(user: self).first_or_create
  end
end
