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
        validates :email, uniqueness: true, presence: { message: 'このメールアドレスは使用できません' }, on: :update
        validates :username, uniqueness: true, presence: { message: '既に他の方に使用されています。' }, on: :update

        mount_base64_uploader :avatar, AvatarUploader
        # mount_uploader :avatar, AvatarUploader
      

        def already_wented?(sauna)
                self.wents.exists?(sauna_id: sauna.id)
        end
        
        def decode_base64_image(encoded_file)
                decoded_file = Base64.decode64(encoded_file)
                file = Tempfile.new(['image','.jpg'])
                file.binmode
                file.write decoded_file
                
                return file
        end
        
       
end

