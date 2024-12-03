
Raclette.destroy_all
User.destroy_all


users = []
5.times do |i|
  users << User.create!(
    email: "user#{i + 1}@gmail.com",
    password: "aaaaaa#{i + 1}",
    password_confirmation: "aaaaaa#{i + 1}",
    first_name: "user#{i + 1}",
    last_name: "Raclette#{i + 1}",
    address: "1 rue de la Gare"
  )
end

5.times do |i|
  Raclette.create!(
    category: Raclette::CATEGORIES.sample,
    capacity: rand(2..20),
    user: users.sample,
    price: rand(10..50),
    description: "Best raclette in town!"
  )
end

puts "seeds créés"
