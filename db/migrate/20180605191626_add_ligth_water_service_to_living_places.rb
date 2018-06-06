class AddLigthWaterServiceToLivingPlaces < ActiveRecord::Migration
  def change
    add_column :living_places, :ligth_service, :string
    add_column :living_places, :water_service, :string
  end
end
