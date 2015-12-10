json.array!(@bands) do |band|
  json.extract! band, :id, :user_id, :name
  json.url band_url(band, format: :json)
end
