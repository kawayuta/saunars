class AddImagesToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :images, :json
  end
end
