Guest.destroy_all
Owner.destroy_all
Accommodation.destroy_all

10.times do
  Guest.create(name: Faker::Name.name)
end

3.times do
  Owner.create(name: Faker::Name.name)
end

Accommodation.create(
  [{ name: 'Charming House', owner_id: Owner.first.id, price_per_night: 50 }],
  [{ name: 'Lisbon Flat', owner_id: Owner.second.id, price_per_night: 100 }],
  [{ name: 'Le Petit Chalet', owner_id: Owner.third.id, price_per_night: 80 }],
  [{ name: 'The Farm House', owner_id: Owner.third.id, price_per_night: 200 }]
)
