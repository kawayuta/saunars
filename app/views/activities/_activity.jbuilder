json.extract! activity, :id, :sauna_id, :user_id, :review_id, :body, :image, :images, :sauna_time, :sauna_count, :mizuburo_time, :mizuburo_count, :rest_time, :rest_count, :created_at, :updated_at
json.url activity_url(activity, format: :json)

json.user activity.user
json.sauna activity.sauna