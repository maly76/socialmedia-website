json.extract! profile, :id, :user_id, :username, :onlyForFriends, :imageurl, :created_at, :updated_at
json.url profile_url(profile, format: :json)
