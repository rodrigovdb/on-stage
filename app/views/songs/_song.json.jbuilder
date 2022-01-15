json.extract! song, :id, :band_id, :name, :artist, :key, :duration, :chords, :created_at, :updated_at
json.url song_url(song, format: :json)
