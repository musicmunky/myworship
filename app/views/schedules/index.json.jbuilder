json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :name, :schedule_date, :notes
  json.url schedule_url(schedule, format: :json)
end
