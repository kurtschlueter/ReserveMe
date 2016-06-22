class Restaurant < ActiveRecord::Base
  has_many :tables
  has_many :images
  has_many :reservations
end
