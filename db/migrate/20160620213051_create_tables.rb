class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.references :restaurant
      t.integer :capacity
      t.timestamps null: false
    end
  end
end
