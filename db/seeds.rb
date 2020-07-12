# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
tags = [
"lotr",
"lordoftherings",
"tolkien",
"thehobbit",
"middleearth",
"jrrtolkien",
"hobbit",
"gandalf"]

tags.each do |tag|
  Tag.create(name: tag)
end

genres = [
  "Drama",
  "Fable",
  "Fairy Tale",
  "Fantasy",
  "Fiction",
  "Fiction in Verse",
  "Folklore",
  "Horror",
  "Humor",
  "Mystery",
  "Poetry",
  "Realistic Fiction"
]

genres.each  do |genre|
  Genre.create(name: genre)
end
