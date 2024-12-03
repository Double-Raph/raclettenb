class CreateRaclettes < ActiveRecord::Migration[7.1]
  def change
    create_table :raclettes do |t|
      t.string :type
      t.integer :capacity
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
