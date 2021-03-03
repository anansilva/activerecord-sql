class Accommodation < ApplicationRecord
  belongs_to :host
  has_many :bookings
  has_many :ratings, through: :bookings
end
