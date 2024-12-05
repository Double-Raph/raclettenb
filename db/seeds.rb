require 'faker'

Faker::Config.locale = 'fr'

# Suppression des anciens enregistrements
Booking.destroy_all
Raclette.destroy_all
User.destroy_all

# Liste d'adresses valides
VALID_ADDRESSES = [
  { address: "10 Rue de la Paix", city: "Paris" },
  { address: "1 Place Bellecour", city: "Lyon" },
  { address: "2 Allée des Dunes", city: "Biarritz" },
  { address: "12 Rue des Orfèvres", city: "Strasbourg" },
  { address: "5 Rue Paradis", city: "Marseille" }
]

# Création de profils utilisateurs fixes
specific_users = [
  { email: "noahdelpit@protonmail.com", first_name: "Noah", last_name: "Delpit" },
  { email: "alban.bengounia@gmail.com", first_name: "Alban", last_name: "Bengounia" },
  { email: "metaypauline@gmail.com", first_name: "Pauline", last_name: "Metay" },
  { email: "raphaelcanches@gmail.com", first_name: "Raphael", last_name: "Canches" }
]

specific_users.each do |user_data|
  address = VALID_ADDRESSES.sample
  User.create!(
    email: user_data[:email],
    password: "aukera",
    password_confirmation: "aukera",
    first_name: user_data[:first_name],
    last_name: user_data[:last_name],
    address: address[:address],
    city: address[:city],
  )
end

# Création de 10 utilisateurs aléatoires
users = []
10.times do
  address = VALID_ADDRESSES.sample
  password = Faker::Internet.password(min_length: 6)
  users << User.create!(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: address[:address],
    city: address[:city],
  )
end

# Création de 10 appareils à raclette
raclette_devices = []
10.times do
  address = VALID_ADDRESSES.sample
  raclette_devices << Raclette.create!(
    category: Raclette::CATEGORIES.sample,
    capacity: rand(2..20),
    user: users.sample,
    price: rand(10..50),
    description: Faker::Lorem.sentence(word_count: 10),
    address: address[:address],
    city: address[:city],
  )
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
