require 'faker'

Faker::Config.locale = 'fr'

Booking.destroy_all
Raclette.destroy_all
User.destroy_all

specific_users = [
  User.create!(
    email: "noahdelpit@protonmail.com",
    password: "aukera",
    first_name: "Noah",
    last_name: "Delpit",
    address: "182 Rue Barreyre, 33300 Bordeaux, France",
  ),
  User.create!(
    email: "alban.bengounia@gmail.com",
    password: "aukera",
    first_name: "Alban",
    last_name: "Bengounia",
    address: "162 Rue Belhara, 64500 Saint-Jean-de-Luz, France",
  ),
  User.create!(
    email: "metaypauline@gmail.com",
    password: "aukera",
    first_name: "Pauline",
    last_name: "Metay",
    address: "58 Rue du Faubourg la Grappe, 28000 Chartres, France",
  ),
  User.create!(
    email: "raphaelcanches@gmail.com",
    password: "aukera",
    first_name: "Raphael",
    last_name: "Canches",
    address: "1 Rue Victor le Gorgeu, 35000 Rennes, France",
  )
]

random_addresses = [
  { address: "3 Av. de Moisan, 40480 Vieux-Boucau-les-Bains, France"},
  { address: "4 Rue des Anges, 77580 Crécy-la-Chapelle, France"},
  { address: "39 Rue du Commerce, 75015 Paris, France"},
  { address: "7 Rue Perelle, 44000 Nantes, France"},
  { address: "6 Rue de la Carbonnerie, 34000 Montpellier, France" },
  { address: "3 Bd Michelet, 13008 Marseille, France"},
  { address: "1 Allées de Chartres, 33000 Bordeaux, France" },
  { address: "43 Rue Chantecrit, 33300 Bordeaux, France" },
  { address: "17 Rue Sainte-Catherine, 33000 Bordeaux, France" },
  { address: "1 Pl. de la Victoire, 33000 Bordeaux, France" },
  { address: "3 Av. Robert Schuman, 33130 Bègles, France" },
  { address: "120-126 Quai de Bacalan, 33300 Bordeaux, France" },
  { address: "20 Cr Saint-Louis, 33300 Bordeaux, France" },
  { address: "131 Cr du Médoc, 33300 Bordeaux, France" },
  { address: "3 All. de Tourny, 33000 Bordeaux, France" },
  { address: "89 Av. Jules Guesde, 33110 Le Bouscat, France" }
]

random_users = random_addresses.map do |data|
  User.create!(
    email: Faker::Internet.email,
    password: "aukera",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: data[:address],
  )
end

users = specific_users + random_users
shuffled_users = users.shuffle


raclettes = shuffled_users.first(10).map do |user|
  Raclette.create!(
    category: Raclette::CATEGORIES.sample,
    capacity: rand(2..20),
    user: user,
    price: rand(10..50),
    description: "Profitez d'une excellente soirée raclette avec cet appareil #{Faker::Food.ingredient} !",
    address: user.address,
  )
end

5.times do
  raclette = raclettes.sample
  renter = users.sample
  renter = users.sample while renter == raclette.user

  Booking.create!(
    user: renter,
    raclette: raclette,
    start_date: Faker::Date.forward(days: 10),
    end_date: Faker::Date.between(from: 11.days.from_now, to: 18.days.from_now),
    status: %w[pending confirmed declined].sample
  )
end

puts "C'est gouda !"
