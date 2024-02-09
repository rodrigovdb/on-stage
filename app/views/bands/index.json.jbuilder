# frozen_string_literal: true

json.array! @bands, partial: 'bands/band', as: :band
