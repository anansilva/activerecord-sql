class Guest < ApplicationRecord
  has_many :bookings
  has_many :payments, through: :bookings
end
