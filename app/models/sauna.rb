class Sauna < ApplicationRecord

    include SaunaSearchable

    has_many :sauna_roles, dependent: :destroy
    has_many :sauna_amenities, dependent: :destroy
    has_many :sauna_rooms, dependent: :destroy
    has_many :sauna_tags, dependent: :destroy

    has_many :wents
    has_many :wented_saunas, through: :wents, source: :user
    has_many :activities
    has_many :activityed_saunas, through: :activities, source: :user
    has_many :reviews, dependent: :destroy
    has_many :reviewed_saunas, through: :activities, source: :user

    mount_uploader :image, ImageUploader

    geocoded_by :address
    after_validation :geocode, if: :address_changed?


    class << self
        def sort_by_distance(lat, lon)
          body = {
            sort: {
              _geo_distance: {
                location: {
                  lat: lat,
                  lon: lon,
                },
                order: 'asc',
                unit: 'meters',
              }
            },
            script_fields: calc_distance_script(lat, lon),
          }
    
          Spot.__elasticsearch__.search(body)
        end
    
        private
    
        def calc_distance_script(lat, lon)
          { distance: {
              params: {
                lat: lat,
                lon: lon,
              },
              script: "doc['location'].distance(lat,lon)", # 点[lat, lon] からの距離をメートル単位で算出
            }
          }
        end
      end
    
end
