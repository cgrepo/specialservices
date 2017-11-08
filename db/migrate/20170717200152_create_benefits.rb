class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.string :name
      t.float :amount
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
