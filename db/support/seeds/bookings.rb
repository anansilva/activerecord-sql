module Support
  module Seeds
    module Bookings
      RANDOM_COMMENTS = {
        1 => ['would not recommend', 'terrible!', 'don\'t go there'],
        2 => ['not good', 'not clean', 'terrible staff', 'bad location'],
        3 => ['meh', 'OKish', 'good enough'],
        4 => ['good place to stay', 'friendly staff', 'great hosts'],
        5 => ['best place ever', 'great staff', 'will come back!', 'fantastic!']
      }.freeze

      def create_past_booking!(guest)
        accommodation = random_accommodation
        total_guests = rand(1..4)
        total_price = calculate_total_price(total_guests, accommodation, past_random_check_in, past_random_check_out)

        Booking.create!(guest_id: guest.id,
                        accommodation_id: accommodation.id,
                        check_in: past_random_check_in, check_out: past_random_check_out,
                        total_guests: total_guests, status: 4).tap do |booking|

                          Payment.create!(booking_id: booking.id, amount: total_price,
                                          status: 1)
                          rate = rand(1..5)
                          Rating.create!(booking_id: booking.id, rate: rate,
                                         comments: RANDOM_COMMENTS[rate])

                        end

      end

      def create_future_booking!(guest)
        accommodation = random_accommodation
        random_check_in = rand(1..5).months.from_now
        random_check_out = random_check_in + rand(2..10).days

        Booking.create!(guest_id: guest.id,
                        accommodation_id: accommodation.id,
                        check_in: random_check_in, check_out: random_check_out,
                        total_guests: rand(1..4), status: rand(0..2))
      end

      private

      def calculate_number_of_nights(check_in, check_out)
        (check_out.to_date - check_in.to_date).to_i
      end

      def calculate_total_price(total_guests, accommodation, check_in, check_out)
        total_guests * accommodation.price_per_night * calculate_number_of_nights(check_in, check_out)
      end

      def random_accommodation
        Accommodation.order('Random()').first
      end

      def past_random_check_in
        rand(1..5).months.ago
      end

      def past_random_check_out
        past_random_check_in + rand(2..10).days
      end

      def future_random_check_in
        rand(1..5).months.from_now
      end

      def future_random_check_out
        future_random_check_in + rand(1..10).days
      end
    end
  end
end
