class AddBornpToPeople < ActiveRecord::Migration
  def change
    add_column :people, :born_place, :string
  end
end
