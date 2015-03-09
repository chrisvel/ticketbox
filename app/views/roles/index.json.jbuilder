json.array!(@roles) do |role|
  json.extract! role, :id, :name, :level, :user_id, :group_id, :owner_id
  json.url role_url(role, format: :json)
end
