json.array!(@events) do |event|
  json.extract! event, :id, :name, :place, :d_event
  json.url event_url(event, format: :json)
end
