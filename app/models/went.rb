class Went < ApplicationRecord
  belongs_to :sauna
  belongs_to :user

  validates_uniqueness_of :sauna_id, scope: :user_id
end
