# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cats = [
  {
    name: 'Moe',
    age: 7,
    enjoys: 'begging for food'
  },
  {
    name: 'Biscuits',
    age: 4,
    enjoys: 'sitting on the window sill'
  },
  {
    name: 'Gravy',
    age: 4,
    enjoys: 'playing with shoestrings'
  },
  {
    name: 'Bruce Willis',
    age: 7,
    enjoys: 'being the mayor of the neighborhood'
  }
]

cats.each do |cat|
  Cat.create cat
  puts "creating the cat: #{cat}"
end
