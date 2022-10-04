class AddVisbleToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :visible, :boolean
  end
end
