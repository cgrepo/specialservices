class CreateExpeditures < ActiveRecord::Migration
  def change
    create_table :expeditures do |t|
      t.float :feeding
      t.float :rent
      t.float :electricity
      t.float :water
      t.float :fuel
      t.float :education
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
