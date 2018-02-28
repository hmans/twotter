# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

hmans = User.create!(name: 'hmans', full_name: 'Hendrik Mans',
  email: 'hendrik@mans.de', password: 'secret')

alice = User.create!(name: 'alice', full_name: 'Alice',
  email: 'alice@test.com', password: 'secret')

hmans.posts.create!(body: 'Hello Twotter!')
alice.posts.create!(body: "Hi, I'm Alice!")

hmans.followed_users << alice
