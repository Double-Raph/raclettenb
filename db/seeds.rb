require 'faker'

Faker::Config.locale = 'fr'

Booking.destroy_all
Raclette.destroy_all
User.destroy_all


def geocode_record(record)
  record.geocode
  record.save!
rescue => e
  puts "Pas de Geocode #{record.address}: #{e.message}"
end

def generate_valid_address
  address = "#{Faker::Address.street_address}, #{Faker::Address.city}, France"
  until valid_geocode?(address)
    address = "#{Faker::Address.street_address}, #{Faker::Address.city}, France"
  end
  address
end

def valid_geocode?(address)
  coords = Geocoder.coordinates(address)
  coords.present?
end

specific_users = [
  { email: "noahdelpit@protonmail.com", first_name: "Noah", last_name: "Delpit" },
  { email: "alban.bengounia@gmail.com", first_name: "Alban", last_name: "Bengounia" },
  { email: "metaypauline@gmail.com", first_name: "Pauline", last_name: "Metay" },
  { email: "raphaelcanches@gmail.com", first_name: "Raphael", last_name: "Canches" }
]

specific_users.each do |user_data|
  address = generate_valid_address
  user = User.create!(
    email: user_data[:email],
    password: "aukera",
    password_confirmation: "aukera",
    first_name: user_data[:first_name],
    last_name: user_data[:last_name],
    address: address,
    city: address.split(",")[1].strip,
    country: "France"
  )
  geocode_record(user)
end

users = []
10.times do
  address = generate_valid_address
  password = Faker::Internet.password(min_length: 6)
  user = User.create!(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: address,
    city: address.split(",")[1].strip,
    country: "France"
  )
  geocode_record(user)
  users << user
end

raclette_devices = []
10.times do
  address = generate_valid_address
  raclette = Raclette.create!(
    category: Raclette::CATEGORIES.sample,
    capacity: rand(2..20),
    user: users.sample,
    price: rand(10..50),
    description: Faker::Lorem.sentence(word_count: 10),
    address: address,
    city: address.split(",")[1].strip,
    country: "France"
  )
  geocode_record(raclette)
  raclette_devices << raclette
end

# Création de 10 réservations
10.times do
  raclette = raclette_devices.sample
  renter = users.sample

  while renter == raclette.user
    renter = users.sample
  end

  start_date = Faker::Date.forward(days: 10)
  end_date = Faker::Date.between(from: start_date + 1, to: start_date + 7)

  Booking.create!(
    user: renter,
    raclette: raclette,
    start_date: start_date,
    end_date: end_date,
    status: %w[pending confirmed declined].sample
  )
end

puts "C'est gouda !"
