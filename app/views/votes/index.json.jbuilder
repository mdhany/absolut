json.array!(@votes) do |vote|
  json.extract! vote, :id, :dj_id, :customer_id
  json.url vote_url(vote, format: :json)
end
