json.extract! friendship_request, :id, :from_user_id, :to_user_id, :created_at, :updated_at
json.url friendship_request_url(friendship_request, format: :json)
