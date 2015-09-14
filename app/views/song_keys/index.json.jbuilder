json.array!(@song_keys) do |song_key|
  json.extract! song_key, :id, :key_symbol, :key_full_name, :key_root, :key_modifier, :capo_fret
  json.url song_key_url(song_key, format: :json)
end
