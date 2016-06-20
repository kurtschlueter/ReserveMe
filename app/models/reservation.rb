class Reservation < ActiveRecord::Base
  belongs_to :table
  belongs_to :user
  belongs_to :restaurant
end
