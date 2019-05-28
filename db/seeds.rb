# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seeding database
require 'faker'
require 'date'

separator = "------------------------------------------------"

puts separator
puts "Seed starts..."

puts separator
puts "0. Destroy existing datas... "

Flat.destroy_all
User.destroy_all
Rental.destroy_all
Dossier.destroy_all
Assignment.destroy_all
Task.destroy_all

puts "... Database is empty! ✔"

puts separator
puts "1. Creating flat owners... "
pswd = '123flater'
# Create team accounts
team = [
  {first_name: 'Raphael', last_name: 'Massonneau', email: 'raph@gmail.com', password: pswd, role: 'admin' },
  {first_name: 'Maxime', last_name: 'Forler', email: 'max@gmail.com', password: pswd, role: 'admin' },
  {first_name: 'Pierre', last_name: 'M\'Baga', email: 'pierre@gmail.com', password: pswd, role: 'admin' },
  {first_name: 'Dareth', last_name: 'NHANG', email: 'dareth@gmail.com', password: pswd, role: 'admin' }
]
team.each do |teamate|
  User.create!(teamate)
end

addresses = [
  '5 Rue Trarieux, Lyon',
  '18 Rue Franklin, Lyon',
  '58 Rue Pasteur, Lyon',
  '22 Rue Smith, Lyon',
  '32 Avenue Felix Faure, Lyon',
  '8 Rue Rollet, Lyon',
  '52 Rue de Sèze, Lyon',
  '10 Rue Mazenod, Lyon',
  '30 Rue Cuvier, Lyon',
  '72 Boulevard Vivier Merle, Lyon',
  '45 Rue de la république, Lyon',
  '67 Rue du Président Edouard Herriot, Lyon',
  '98 Rue Paul Bert, Lyon',
  '20 Rue des capucins, Lyon',
  '3 Avenue Lacassagne, Lyon',
  '132 Avenue Lacassagne, Lyon',
  '48 Rue Garibaldi, Lyon',
  '10 Rue de la charité, Lyon',
  '57 Rue de Marseille, Lyon',
  '3 Rue Chevreul, Lyon',
  '12 Rue de la Thibaudière, Lyon',
  '3 Rue Père Chevrier, Lyon',
  '7 Rue du Plat, Lyon',
  '9 Rue de Condé, Lyon',
  '5 Rue Servient, Lyon',
  '65 Rue Bossuet, Lyon',
  '12 Rue de la république, Lyon',
  '45 Rue Trarieu, Lyon'
]

puts "2. Creating flats for owners... "

User.all.each do |user|

  # Creating flats 
  3.times do |i|
    flat = Flat.create!(
      address: addresses.sample,
      owner: user,
      #NB: important to write "owner" and not to use "owner_id"
      to_rent: true,
      surface: rand(30..50),
      nb_rooms: rand(2..4),
      furnished: true,
      description: "Very nice flat with awesome view!"
    )

    # Creating pending rental for each flat
  #     Rental.create!(
  #       flat_id: flat.id.to_i,
  #       tenant: nil,
  #       description: "A great flat, which is available!",
  #       start_date: Date.today,
  #       pending: true,
  #       initial_rent: 800
  #     )
  end

end

puts separator
puts "Seed is finished ;-)"
puts separator
