class CreateSaunas < ActiveRecord::Migration[6.1]
  def change
    create_table :saunas do |t|
      t.string :name_ja, unique: true
      t.string :name_en
      t.text :description
      t.text :address
      t.integer :gender
      t.string :thumbnail
      t.string :image
      
      t.integer :price
      t.string :holiday
      t.string :tel
      t.string :parking
      t.string :hp
      
      t.timestamps
    end
  end
end
