json.array!(@requirements) do |requirement|
  json.extract! requirement, :id, :client_id, :user_id, :description, :date, :budget
  json.url requirement_url(requirement, format: :json)
end
