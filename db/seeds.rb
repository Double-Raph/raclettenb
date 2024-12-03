
Raclette.destroy_all
User.destroy_all


users = []
5.times do |i|
  users << User.create!(
    email: "user#{i + 1}@gmail.com",
    password: "aaaaaa#{i + 1}",
    password_confirmation: "aaaaaa#{i + 1}"
  )
end

5.times do |i|
  Raclette.create!(
    type: Raclette::CATEGORIES.sample,
    capacity: rand(2..20),
    user: users.sample,
    price: rand(10..50),
    description: "Best raclette in town!"
  )
end

puts "seeds créés"
