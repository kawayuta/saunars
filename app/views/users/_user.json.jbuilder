json.extract! user, :id, :username, :created_at, :updated_at
json.url user_url(user, format: :json)
json.wents user.wents.pluck(:sauna_id).map { |id| Sauna.find(id) }
