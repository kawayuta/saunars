class Activity < ApplicationRecord
    belongs_to :sauna
    belongs_to :user
    belongs_to :review
    accepts_nested_attributes_for :review, :allow_destroy => true

    mount_uploaders :images, ActivityImageUploader
        
    def parsed_tags(images)
        return JSON.parse(images) if images.present?
        {}
    end

    def self.decode_base64_image(encoded_file)
        decoded_file = Base64.decode64(encoded_file)
        file = Tempfile.new(['image','.jpg'])
        file.binmode
        file.write decoded_file
        
        return file
    end
end
