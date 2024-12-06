class AddCountryToRaclettes < ActiveRecord::Migration[7.1]
  def change
    add_column :raclettes, :country, :string
  end
end
