class AddSalaryToResponsables < ActiveRecord::Migration
  def change
    add_column :responsables, :salary, :float
  end
end
