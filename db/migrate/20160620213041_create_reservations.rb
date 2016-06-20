class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.time :start_time
      t.time :end_time
      t.integer :party_number
      t.references :restaurant
      t.references :user
      t.references :table
      t.timestamps null: false
    end
  end
end
