def calculate_number_of_nights(check_in, check_out)
  (check_out.to_date - check_in.to_date).to_i
end

def calculate_total_price(accommodation, check_in, check_out)
  accommodation.price_per_night * calculate_number_of_nights(check_in, check_out)
end

def random_accommodation
  Accommodation.order('Random()').first
end

puts 'pruning all data'
Accommodation.destroy_all
Booking.destroy_all
Host.destroy_all
Guest.destroy_all

puts 'creating hosts'
3.times do
  Host.create(name: Faker::Name.name)
end

puts 'creating accommodations'
Accommodation.create([
  { name: 'Charming House', host_id: Host.first.id, price_per_night: 50 },
  { name: 'Lisbon Flat', host_id: Host.second.id, price_per_night: 100 },
  { name: 'Le Petit Chalet', host_id: Host.third.id, price_per_night: 80 },
  { name: 'The Farm House', host_id: Host.third.id, price_per_night: 200 }
])


puts 'creating guests with future bookings'
4.times do
  Guest.create(name: Faker::Name.name).tap do |guest|
    random_check_in = rand(1..5).months.from_now
    random_check_out = random_check_in + rand(2..10).days
    Booking.create(guest_id: guest.id,
                   accommodation_id: Accommodation.order('Random()').first,
                   check_in: random_check_in, check_out: random_check_out,
                   total_guests: rand(1..4), status: rand(0..2))
  end
end

puts 'creating guests with past bookings'
RANDOM_COMMENTS = {
  1 => ['would not recommend', 'terrible!', 'don\'t go there'],
  2 => ['not good', 'not clean', 'terrible staff', 'bad location'],
  3 => ['meh', 'OKish', 'good enough'],
  4 => ['good place to stay', 'friendly staff', 'great hosts'],
  5 => ['best place ever', 'great staff', 'will come back!', 'fantastic!']
}.freeze

2.times do
  Guest.create(name: Faker::Name.name).tap do |guest|
    random_check_in = rand(1..5).months.ago
    random_check_out = random_check_in + rand(2..10).days

    accommodation = random_accommodation
    total_price = calculate_total_price(accommodation, random_check_in, random_check_out)

    Booking.create(guest_id: guest.id,
                   accommodation_id: accommodation.id,
                   check_in: random_check_in, check_out: random_check_out,
                   total_guests: rand(1..4), status: 4).tap do |booking|

                     Payment.create(booking_id: booking.id, amount: total_price,
                                   status: 1)
                     rate = rand(1..5)
                     Rating.create(booking_id: booking.id, rate: rate,
                                   comments: RANDOM_COMMENTS[rate])

                   end

  end
end

puts 'creating guests with past and future bookings'
2.times do
  Guest.create(name: Faker::Name.name).tap do |guest|
    past_random_check_in = rand(1..5).months.ago
    past_random_check_out = past_random_check_in + rand(2..10).days

    future_random_check_in = rand(1..5).months.from_now
    future_random_check_out = future_random_check_in + rand(1..10).days

    accommodation = random_accommodation
    total_price = calculate_total_price(accommodation, past_random_check_in, past_random_check_out)

    Booking.create(guest_id: guest.id,
                   accommodation_id: accommodation.id,
                   check_in: past_random_check_in, check_out: past_random_check_out,
                   total_guests: rand(1..4), status: rand(0..2)).tap do |booking|
                     Payment.create(booking_id: booking.id, amount: total_price,
                                   status: 1)
                     rate = rand(1..5)
                     Rating.create(booking_id: booking.id, rate: rate,
                                   comments: RANDOM_COMMENTS[rate])
                   end

    accommodation = random_accommodation
    Booking.create(guest_id: guest.id,
                   accommodation_id: accommodation.id,
                   check_in: future_random_check_in, check_out: future_random_check_out,
                   total_guests: rand(1..4), status: 4)
  end
end
