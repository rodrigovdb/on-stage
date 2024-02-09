# frozen_string_literal: true

json.extract! band, :id, :user_id, :name, :created_at, :updated_at
json.url band_url(band, format: :json)
