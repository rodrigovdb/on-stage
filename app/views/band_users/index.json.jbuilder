# frozen_string_literal: true

json.array! @band_users, partial: 'band_users/band_user', as: :band_user
