json.array!(@entries) do |entry|
  json.extract! entry, :id, :customer_id, :event_id, :post, :gift
  json.url entry_url(entry, format: :json)
end
