json.extract! user, :id, :username, :created_at, :updated_at
json.url user_url(user, format: :json)
json.wents user.wents.order(id: :DESC).pluck(:sauna_id).map { |id| Sauna.find(id) }
json.activities user.activities.order(id: :DESC)
json.activities_reviews user.activities.order(id: :DESC).pluck(:review_id).map { |id| Review.find(id) }
json.activities_saunas user.activities.order(id: :DESC).pluck(:sauna_id).map { |id| Sauna.find(id) }