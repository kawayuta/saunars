class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.text :body
      t.string :image
      t.integer :sauna_time
      t.integer :sauna_count
      t.integer :mizuburo_time
      t.integer :mizuburo_count
      t.integer :rest_time
      t.integer :rest_count
      t.references :sauna, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.timestamps
    end
  end
end
