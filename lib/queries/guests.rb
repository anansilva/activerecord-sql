module Queries
  class Guests
    # has_many joins

    # Guest.count => 10
    # .join = inner join
    # Guest.count => 10
    # But wait, not all guests are included in this list, don't be fulled by the
    # number 10, it's just a coincidence
    # Why?
    # Because inner jois only brings the guests that match with bookings
    # Can bring duplicate guests. It will return the same guest for the n number
    # o bookings
    def self.guests_with_bookings
      Guest.joins(:bookings)
    end

    # Guest.count = > 10
    # left outer join
    # guest.count => 12
    def self.guests_with_and_without_bookings
      Guest.left_joins(:bookings)
    end
  end
end
