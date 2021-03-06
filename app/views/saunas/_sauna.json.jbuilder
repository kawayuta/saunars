json.extract! sauna, :id, :name_ja, :address, :latitude, :longitude, :tel, :holiday, :image, :hp, :feed, :price, :created_at, :updated_at
json.url sauna_url(sauna, format: :json)
json.is_went signed_in? ? sauna.wents.find_by(user_id: current_user.id).present? : false
json.went_count Rails.cache.fetch("went_count_#{sauna.id}", expires_in: 60.minutes) { sauna.wents.count }
json.rooms sauna.sauna_rooms
json.roles sauna.sauna_roles
json.amenities sauna.sauna_amenities
json.reviews sauna.reviews.order(id: :DESC).limit(10)
json.parking sauna.parking.include?("-") || sauna.parking.include?("なし") || sauna.parking.include?("無") && !sauna.parking.include?("有") ? "無し" : "有り"
