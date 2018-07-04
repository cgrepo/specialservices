class RemoveNotesLivingPlaces < ActiveRecord::Migration
  def change
    remove_column :living_places, :notes
  end
end
