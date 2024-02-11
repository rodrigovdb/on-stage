json.extract! setlist_song, :id, :setlist_id, :song_id, :display_sort, :created_at, :updated_at
json.url setlist_song_url(setlist_song, format: :json)
