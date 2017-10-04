class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :civil_status
      t.string :occupation
      t.string :adddress
      t.string :workplace
      t.string :relationship
      t.string :salary
      t.string :scolarship
      t.references :Person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
