# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
10.times do |i|
  Post.create!(
    title: "Title",
    description: "Description",
    location: "#{i*10} NW 1st St., Miami, FL",
    tag: "tag",
    price: 100,
    user_id: 2,
    phone_number: "1800abcdefg"
  ).latlng
end
