class CreateOtherExpeditures < ActiveRecord::Migration
  def change
    create_table :other_expeditures do |t|
      t.string :name
      t.float :amount
      t.references :expediture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
