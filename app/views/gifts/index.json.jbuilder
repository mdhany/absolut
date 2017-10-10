json.array!(@gifts) do |gift|
  json.extract! gift, :id, :name, :inventory, :predicted, :priority, :event_id
  json.url gift_url(gift, format: :json)
end
