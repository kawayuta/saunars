class User < ApplicationRecord
        devise :database_authenticatable, :registerable, :recoverable,
        :rememberable,  :validatable, :omniauthable
        
        include DeviseTokenAuth::Concerns::User

        has_many :wents, dependent: :destroy
        has_many :wented_saunas, through: :wents, source: :saunas
        has_many :activities, dependent: :destroy
        has_many :activityed_saunas, through: :activities, source: :saunas
        has_many :reviews, dependent: :destroy
        has_many :reviewed_saunas, through: :activities, source: :saunas

        def already_wented?(sauna)
                self.wents.exists?(sauna_id: sauna.id)
        end
end
