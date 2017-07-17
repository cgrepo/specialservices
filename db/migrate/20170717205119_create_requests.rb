class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :case
      t.date :rdate
      t.string :sent_by
      t.string :oriented
      t.string :service
      t.text :notes
      t.float :qualification
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
