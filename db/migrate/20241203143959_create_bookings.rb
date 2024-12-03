class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :raclette, null: false, foreign_key: true

      t.timestamps
    end
  end
end
