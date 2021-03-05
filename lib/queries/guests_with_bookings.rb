module Queries
  class GuestsWithBookings
    def self.call
      Guest.join(:bookings)
    end
  end
end
