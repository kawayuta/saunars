json.extract! sauna, :id, :name_ja, :address, :latitude, :longitude, :tel, :image, :hp, :price, :parking, :created_at, :updated_at
json.url sauna_url(sauna, format: :json)
json.is_went signed_in? ? sauna.wents.find_by(user_id: current_user.id).present? : false
json.rooms sauna.sauna_rooms
json.roles sauna.sauna_roles
json.amenities sauna.sauna_amenities