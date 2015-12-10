json.array!(@setlists) do |setlist|
  json.extract! setlist, :id, :band_id, :name, :date, :notes
  json.url setlist_url(setlist, format: :json)
end
