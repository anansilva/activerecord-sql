class Booking < ApplicationRecord
  belongs_to :guest
  belongs_to :accommodation
  has_many :payments
  has_many :ratings

  enum status: %w[requested confirmed canceled checked_in checked_out]
end
