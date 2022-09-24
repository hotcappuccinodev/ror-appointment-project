class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.decimal :price
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
