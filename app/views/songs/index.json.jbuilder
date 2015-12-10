json.array!(@songs) do |song|
  json.extract! song, :id, :band_id, :name
  json.url song_url(song, format: :json)
end
