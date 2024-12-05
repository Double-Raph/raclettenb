class AddColumnToRaclettes < ActiveRecord::Migration[7.1]
  def change
    add_column :raclettes, :city, :string, default: "Soustons"
  end
end
