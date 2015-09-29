json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :user_id, :description, :start_time, :end_time
  json.url attendance_url(attendance, format: :json)
end
