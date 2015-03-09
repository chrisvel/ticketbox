json.array!(@memberships) do |membership|
  json.extract! membership, :id, :name, :typeof, :user_id, :group_id, :owner_id
  json.url membership_url(membership, format: :json)
end
