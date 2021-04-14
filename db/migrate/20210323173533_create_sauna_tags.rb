class CreateSaunaTags < ActiveRecord::Migration[6.1]
  def change
    create_table :sauna_tags do |t|
      t.references :sauna, foreign_key: true
      t.string :title
      t.timestamps
    end
  end
end
