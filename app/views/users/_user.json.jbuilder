json.extract! user, :id, :username, :name, :email, :created_at, :updated_at, :avatar
json.url user_url(user, format: :json)
json.wents user.wents.order(id: :DESC).pluck(:sauna_id).map { |id| Sauna.find(id) }
json.activities user.activities.order(id: :DESC)
json.activities_reviews user.activities.order(id: :DESC).pluck(:review_id).map { |id| Review.find(id) }
json.activities_saunas user.activities.order(id: :DESC).pluck(:sauna_id).map { |id| Sauna.find(id) }
json.activities_month_saunas_rooms user.activities.where(updated_at: Time.zone.today.beginning_of_month..Time.zone.today.end_of_month).order(id: :DESC).pluck(:sauna_id).map { |id| Sauna.find_by(id: id).sauna_rooms.first }.flatten
json.activities_month user.activities.where(updated_at: Time.zone.today.beginning_of_month..Time.zone.today.end_of_month)

