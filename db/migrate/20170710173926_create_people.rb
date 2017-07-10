class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :kind
      t.string :name
      t.integer :age
      t.string :civil_status
      t.string :occupation
      t.float :salary
      t.string :scolarship
      t.string :address
      t.string :workplace
      t.string :current_residence
      t.string :relationship
      t.string :phone
      t.date :admission_date
      t.date :birth_date
      t.string :transportation

      t.timestamps null: false
    end
  end
end
