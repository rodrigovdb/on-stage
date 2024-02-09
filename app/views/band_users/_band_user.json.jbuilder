# frozen_string_literal: true

json.extract! band_user, :id, :band_id, :user_id, :owner, :created_at, :updated_at
json.url band_user_url(band_user, format: :json)
