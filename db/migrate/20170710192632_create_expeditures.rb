class CreateExpeditures < ActiveRecord::Migration
  def change
    create_table :expeditures do |t|
      t.float :feeding
      t.float :rent
      t.float :electricity
      t.float :water
      t.float :fuel
      t.float :education
      t.string :other
      t.string :benefit

      t.timestamps null: false
    end
  end
end
