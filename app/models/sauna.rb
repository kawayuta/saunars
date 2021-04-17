class Sauna < ApplicationRecord

    include SaunaSearchable

    has_many :sauna_roles, dependent: :destroy
    has_many :sauna_amenities, dependent: :destroy
    has_many :sauna_rooms, dependent: :destroy
    has_many :sauna_tags, dependent: :destroy

    has_many :wents
    has_many :wented_saunas, through: :wents, source: :user

    mount_uploader :image, ImageUploader

    geocoded_by :address
    after_validation :geocode, if: :address_changed?
end
