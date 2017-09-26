class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|
      t.string :name
      t.integer :age
      t.string :civil_status
      t.string :gender
      t.string :occupation
      t.float :salary
      t.string :scolarship
      t.string :relationship

      t.timestamps null: false
    end
  end
end
