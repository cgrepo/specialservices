class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :name
      t.string :pname
      t.string :mname
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
