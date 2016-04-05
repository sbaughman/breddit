# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, bio: Faker::Hipster.paragraphs(2).join("\n\n"), username: Faker::Internet.domain_word, password: "password")
end

10.times do
  Sub.create!(name: Faker::StarWars.planet, description: Faker::Hipster.paragraphs(2).join("\n\n"))
end

50.times do
  Link.create!(title: Faker::Hipster.sentence, url: Faker::Internet.url, summary: Faker::Lorem.paragraph, user_id: rand(1..10), sub_id: rand(1..10))
end

200.times do
  Comment.create!(content: Faker::Hacker.say_something_smart, user_id: rand(1..10), link_id: rand(1..50))
end

2500.times do
  Vote.create!(value: [-5,5,5].sample, link_id: rand(1..50), user_id: rand(1..10))
end

2500.times do
  Click.create!(value: 1, link_id: rand(1..50), user_id: rand(1..10))
end
