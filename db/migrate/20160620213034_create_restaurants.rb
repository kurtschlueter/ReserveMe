class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :city
      t.string :address
      t.string :phone_number
      t.string :image_url
      t.timestamps null: false
    end
  end
end
