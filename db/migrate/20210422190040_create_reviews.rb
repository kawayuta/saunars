class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :cleanliness
      t.integer :customer_service
      t.integer :equipment
      t.integer :customer_manner
      t.integer :cost_performance
      t.references :sauna, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
