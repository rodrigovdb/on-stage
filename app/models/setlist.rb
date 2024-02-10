# frozen_string_literal: true

class Setlist < ApplicationRecord
  belongs_to :band

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
