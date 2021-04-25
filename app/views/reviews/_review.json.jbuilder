json.extract! review, :id, :cleanliness, :customer_service, :equipment, :customer_manner, :cost_performance ,:created_at, :updated_at
json.url review_url(review, format: :json)
