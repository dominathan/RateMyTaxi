json.array!(@users) do |user|
  json.extract! user, :id, :company_name, :taxi_count
  json.url user_url(user, format: :json)
end
