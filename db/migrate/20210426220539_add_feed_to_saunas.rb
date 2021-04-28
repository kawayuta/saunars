class AddFeedToSaunas < ActiveRecord::Migration[6.1]
  def change
    add_column :saunas, :feed, :longtext
  end
end
