require_relative 'support/seeds/bookings.rb'
include ::Support::Seeds::Bookings

puts 'pruning all data'
Payment.destroy_all
Rating.destroy_all
Booking.destroy_all
Accommodation.destroy_all
Host.destroy_all
Guest.destroy_all

puts 'creating hosts'
3.times do
  Host.create!(name: Faker::Name.name)
end

puts 'creating accommodations'
Accommodation.create!([
  { name: 'Charming House', host_id: Host.first.id, price_per_night: 50 },
  { name: 'Lisbon Flat', host_id: Host.second.id, price_per_night: 100 },
  { name: 'Le Petit Chalet', host_id: Host.third.id, price_per_night: 80 },
  { name: 'The Farm House', host_id: Host.third.id, price_per_night: 200 }
])


puts 'creating guests with future bookings and payments'
4.times do
  Guest.create!(name: Faker::Name.name).tap do |guest|
    create_future_booking!(guest)
  end
end

puts 'creating guests with past bookings, payments and ratings'
2.times do
  Guest.create!(name: Faker::Name.name).tap do |guest|
    create_past_booking!(guest)
  end
end

puts 'creating guests with past bookings and payments but no ratings'
1.times do
  Guest.create!(name: Faker::Name.name).tap do |guest|
    create_past_booking_with_no_rating!(guest)
  end
end

puts 'creating guests with past bookings and ratings but no payments'
1.times do
  Guest.create!(name: Faker::Name.name).tap do |guest|
    create_past_booking_with_no_payment!(guest)
  end
end

puts 'creating guests with past and future bookings, payments and ratings'
2.times do
  Guest.create!(name: Faker::Name.name).tap do |guest|
    create_past_booking!(guest)
    create_future_booking!(guest)
  end
end

puts 'creating guests with no bookings'
2.times do
  Guest.create!(name: Faker::Name.name)
end

puts 'create an accommodation with no booking'
Accommodation.create!(name: 'Beach House', host_id: Host.first.id, price_per_night: 77)
