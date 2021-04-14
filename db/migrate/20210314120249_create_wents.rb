class CreateWents < ActiveRecord::Migration[6.1]
  def change
    create_table :wents do |t|
      t.references :sauna, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
