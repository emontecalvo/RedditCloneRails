# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'


10.times do
  User.create(username: Faker::Hipster.word, password: "password")
end

10.times do
  Sub.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: (1..10).to_a.sample)
end

Sub.all.each do |sub|
  (1..15).to_a.sample.times do
    Post.create(content: Faker::Hipster.paragraph, title: Faker::Hipster.sentence, sub_id: sub.id, user_id: (1..10).to_a.sample)
  end
end
