# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

puts "Cleaning database..."
Raclette.destroy_all
User.destroy_all

puts "Creating users..."
user1 = User.create!(
  email: "michel@example.com",
  password: "password"
)

user2 = User.create!(
  email: "sophie@example.com",
  password: "password"
)

puts "Creating raclettes..."
Raclette.create!(
  type: "vertical",
  capacity: 8,
  user: user1,
  price: 25,
  description: "Appareil à raclette vertical"
)

Raclette.create!(
  type: "bougies",
  capacity: 2,
  user: user2,
  price: 15,
  description: "Petit appareil à raclette pour deux personnes"
)

Raclette.create!(
  type: "poelons",
  capacity: 12,
  user: user1,
  price: 35,
  description: "Appareil grande capacité"
)

puts "Finished!"
