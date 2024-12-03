class RenameTypeToCategoryInRaclettes < ActiveRecord::Migration[7.1]
  def change
    rename_column :raclettes, :type, :category
  end
end
