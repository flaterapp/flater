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

puts separator
puts "2. Creating flats for owners... "
addresses = [
  '65 rue Bossuet, Lyon',
  '20 rue des Capucins, Lyon',
  '10 rue de la Charité, Lyon',
  '3 rue Chevreul, Lyon',
  '9 rue de Condé, Lyon',
  '30 rue Cuvier, Lyon',
  '34 avenue Debourg, Lyon',
  '32 avenue Felix Faure, Lyon',
  '18 rue Franklin, Lyon',
  '48 rue Garibaldi, Lyon',
  '3 rue Père Chevrier, Lyon',
  '3 avenue Lacassagne, Lyon',
  '132 avenue Lacassagne, Lyon',
  '57 rue de Marseille, Lyon',
  '10 rue Mazenod, Lyon',
  '58 rue Pasteur, Lyon',
  '98 rue Paul Bert, Lyon',
  '4 quai Perrache, Lyon',
  '70 quai Perrache, Lyon',
  '7 rue du Plat, Lyon',
  '67 rue du Président Edouard Herriot, Lyon',
  '12 rue de la République, Lyon',
  '45 rue de la République, Lyon',
  '57 rue de la République, Lyon',
  '8 rue Rollet, Lyon',
  '11 rue Sainte-Catherine, Lyon',
  '5 rue Servient, Lyon',
  '52 rue de Sèze, Lyon',
  '22 rue Smith, Lyon',
  '12 rue de la Thibaudière, Lyon',
  '5 rue Trarieux, Lyon',
  '45 rue Trarieux, Lyon',
  '72 boulevard Vivier Merle, Lyon'
]

User.all.each do |user|

  # Creating flats with pending rentals (and applications)
  2.times do |i|

    flat = Flat.create!(
      address: addresses.sample,
      owner: user,
      #NB: important to write "owner" and not to use "owner_id"
      to_rent: true,
      # NOTE REALLY USED!
      surface: rand(30..50),
      nb_rooms: rand(2..4),
      furnished: true,
      description: "Very nice flat with awesome view!"
    )

    # Creating pending rental for each flat
      rental = Rental.create!(
        flat: flat,
        tenant: nil,
        description: "A great flat, which is available!",
        start_date: Date.today,
        pending: true,
        initial_rent: 800
      )

    # Creating several dossiers for each rental
    rand(2..12).times do
      candidate =  User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: pswd,
        role: nil
      )
        Dossier.create!(
          rental: rental,
          candidate: candidate,
          start_date: Date.today,
          status: ["not_selected","to_improve","ok_for_visit","visiting"].sample,
          monthly_revenues: [1600, 2100, 2800, 3200, 4600].sample
        )
    end
  end

    # Creating flats which are already rented
    3.times do |i|
      flat = Flat.create!(
        address: addresses.sample,
        owner: user,
        #NB: important to write "owner" and not to use "owner_id"
        to_rent: false,
        # NOTE REALLY USED!
        surface: rand(30..50),
        nb_rooms: rand(2..4),
        furnished: true,
        description: "Very nice flat with awesome view!"
      )

      # Creating an on-going rental for each flat
        candidate =  User.create!(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          password: pswd,
          role: nil
        )

        rental = Rental.create!(
          flat: flat,
          tenant: nil,
          description: "A great flat, which is now rented!",
          start_date: Date.today,
          pending: false,
          initial_rent: 800
        )
  end

########### ISSUE: need to allocate a candidate to a flat (as tenant)

end

puts separator
puts "Seed is finished ;-)"
puts separator
