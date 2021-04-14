class CreateSaunaRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :sauna_rooms do |t|
      t.references :sauna, foreign_key: true
      t.integer :sauna_temperature
      t.integer :mizu_temperature
      t.integer :gender

      t.timestamps
    end
  end
end
