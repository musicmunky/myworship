json.array!(@songs) do |song|
  json.extract! song, :id, :name, :author, :song_key, :capo_fret, :media_link
  json.url song_url(song, format: :json)
end
