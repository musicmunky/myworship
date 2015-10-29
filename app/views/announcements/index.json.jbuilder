json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :heading, :message, :is_active, :user_id
  json.url announcement_url(announcement, format: :json)
end
