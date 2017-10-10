json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :birth, :city, :mobile, :email, :interest, :entry_id
  json.url customer_url(customer, format: :json)
end
