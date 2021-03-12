module Queries
  class Payments
    #belongs_to assocation
    # Find all payments of requested bookings
    def self.payments_with_bookings
      Payment.joins(:booking)
    end

    def self.payment_with_requested_bookings
      Payment.joins(:booking).where(bookings: { status: 'requested' })
    end

    def self.payment_with_requested_bookings_includes
      Payment.includes(:booking).where(bookings: { status: 'requested' })
    end

    # 11 queries -> the famous n + 1 query
    def self.payment_with_requested_bookings_ruby_way
      Payment.all.select { |payment| payment.booking.requested? }
    end
  end
end

