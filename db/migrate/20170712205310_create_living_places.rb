class CreateLivingPlaces < ActiveRecord::Migration
  def change
    create_table :living_places do |t|
      t.string :kind
      t.string :wall_mat
      t.string :roof_mat
      t.string :floor_mat
      t.integer :rooms
      t.string :bedroom
      t.string :kitchen
      t.string :dinningroom
      t.string :bathroom
      t.text :notes
      t.string :lighting_service
      t.string :water_service
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
