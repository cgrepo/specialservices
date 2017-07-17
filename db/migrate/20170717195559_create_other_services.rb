class CreateOtherServices < ActiveRecord::Migration
  def change
    create_table :other_services do |t|
      t.string :name
      t.references :living_place, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
