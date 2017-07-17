class CreateLivingPlaces < ActiveRecord::Migration
  def change
    create_table :living_places do |t|
      t.string :kind
      t.string :wall_material
      t.string :roof_material
      t.string :floor_material
      t.integer :number_of_rooms
      t.boolean :has_beedroom
      t.boolean :has_kitchen
      t.boolean :has_dinningroom
      t.boolean :has_bathroom
      t.text :notes
      t.references :Person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
