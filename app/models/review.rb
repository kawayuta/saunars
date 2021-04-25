class Review < ApplicationRecord
    belongs_to :sauna
    belongs_to :user
end
