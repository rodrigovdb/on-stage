# frozen_string_literal: true

class Band < ApplicationRecord
  has_many :band_users, dependent: :destroy
  has_many :users, through: :band_users

  has_many :songs, dependent: :destroy
  has_many :setlists, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }

  def owner
    band_users.find_by(role: :owner).user
  end
end
