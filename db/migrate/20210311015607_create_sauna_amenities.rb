class CreateSaunaAmenities < ActiveRecord::Migration[6.1]
  def change
    create_table :sauna_amenities do |t|
      t.references :sauna, foreign_key: true
      t.boolean :shampoo, default: false
      t.boolean :conditioner, default: false
      t.boolean :body_soap, default: false
      t.boolean :face_soap, default: false
      t.boolean :razor, default: false
      t.boolean :toothbrush, default: false
      t.boolean :nylon_towel, default: false
      t.boolean :hairdryer, default: false
      t.boolean :face_towel_unlimited, default: false
      t.boolean :bath_towel_unlimited, default: false
      t.boolean :sauna_underpants_unlimited, default: false
      t.boolean :sauna_mat_unlimited, default: false
      t.boolean :flutterboard_unlimited, default: false
      t.boolean :toner, default: false
      t.boolean :emulsion, default: false
      t.boolean :makeup_remover, default: false
      t.boolean :cotton_swab, default: false

      t.timestamps
    end
  end
end
