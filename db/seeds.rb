# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, bio: Faker::Hipster.paragraphs(2).join("\n\n"))
end

50.times do
  Link.create!(title: Faker::Hipster.sentence, url: Faker::Internet.url, summary: Faker::Lorem.paragraph, user_id: rand(1..10))
end

5000.times do
  Vote.create!(value: [-1,1,1].sample, link_id: rand(1..50))
end
