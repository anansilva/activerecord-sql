class Booking < ApplicationRecord
  belongs_to :guest
  belongs_to :accommodation

  enum status: %w[requested confirmed canceled checked_in checked_out]
end
