class RemoveKindFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :kind, :string
  end
end
