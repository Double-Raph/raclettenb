class AddCoordinatesToRaclettes < ActiveRecord::Migration[7.1]
  def change
    add_column :raclettes, :latitude, :float
    add_column :raclettes, :longitude, :float
  end
end
