class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :civil_status
      t.string :occupation
      t.string :address
      t.string :workplace
      t.string :relationship
      t.references :Person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
