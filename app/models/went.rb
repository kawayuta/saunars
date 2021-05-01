class Went < ApplicationRecord
  belongs_to :sauna
  belongs_to :user

  validates_uniqueness_of :sauna_id, scope: :user_id


  def createWent(user_id, sauna_id)
    Went.create(user_id: user_id, sauna_id: sauna_id)
  end
end
