class Booking < ApplicationRecord
  belongs_to :guest
  belongs_to :accommodation
  belongs_to :payment

  enum status: %w[requested confirmed canceled checked_in checked_out]
end
