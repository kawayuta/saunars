class CreateSaunaRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :sauna_roles do |t|
      t.references :sauna, foreign_key: true
      t.boolean :loyly, default: false
      t.boolean :auto_loyly, default: false
      t.boolean :self_loyly, default: false
      t.boolean :gaikiyoku, default: false
      t.boolean :rest_space, default: false

      t.boolean :free_time, default: false
      t.boolean :capsule_hotel, default: false
      t.boolean :in_rest_space, default: false
      t.boolean :eat_space, default: false
      t.boolean :wifi, default: false

      t.boolean :power_source, default: false
      t.boolean :work_space, default: false
      t.boolean :manga, default: false
      t.boolean :body_care, default: false
      t.boolean :body_towel, default: false
      t.boolean :water_dispenser, default: false
      t.boolean :washlet, default: false
      t.boolean :credit_settlement, default: false
      t.boolean :parking_area, default: false
      t.boolean :ganbanyoku, default: false
      t.boolean :tattoo, default: false

      t.timestamps
    end
  end
end
