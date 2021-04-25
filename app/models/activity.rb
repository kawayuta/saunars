class Activity < ApplicationRecord
    belongs_to :sauna
    belongs_to :user
    belongs_to :review
    accepts_nested_attributes_for :review, :allow_destroy => true
end
