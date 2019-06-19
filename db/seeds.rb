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

separator = "-------------------------------------------------"

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
Conversation.destroy_all

puts "... Database is empty! ✔"

puts separator
puts "1. Creating flat owners... "
pswd = '123flater'
# Create team accounts
team = [
  {first_name: 'Raphael', last_name: 'Massonneau', email: 'raph@gmail.com', password: pswd, role: 'admin', facebook_picture_url: 'https://avatars2.githubusercontent.com/u/44228371?v=4' },
  {first_name: 'Maxime', last_name: 'Forler', email: 'max@gmail.com', password: pswd, role: 'admin', facebook_picture_url: 'https://res.cloudinary.com/dtwpyokni/image/upload/v1558705228/maxime.jpg' },
  {first_name: 'Pierre', last_name: 'M\'Baga', email: 'pierre@gmail.com', password: pswd, role: 'admin', facebook_picture_url: 'https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/z32znj9l5x2xy1psb36x.jpg' },
  {first_name: 'Dareth', last_name: 'NHANG', email: 'dareth@gmail.com', password: pswd, role: 'admin', facebook_picture_url: 'https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/gazjce34qg6yvwltrnqq.jpg' }
]
team.each do |teamate|
  User.create!(teamate)
end

puts separator
puts "2. Creating flats for owners... "

addresses_1 = [
  '65 rue Bossuet, Lyon'
]

addresses_2 = [
  '20 rue des Capucins, Lyon']

addresses_3 = [
  '10 rue de la Charité, Lyon']

addresses_4 = [
  '9 rue de Condé, Lyon',
  '30 rue Cuvier, Lyon',
  '34 avenue Debourg, Lyon']

other_adresses = [
  '3 rue Chevreul, Lyon',
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

  ###################################################################
  # 1. FAKER - Creating flats with pending rentals (and applications)
  ###################################################################

  addresses_1.each do |address|
    nb_rooms = rand(2..4)
    flat = Flat.create!(
      address: address,
      owner: user,
      #NB: important to write "owner" and not to use "owner_id"
      to_rent: true,
      # NOTE REALLY USED!
      a_type: "T#{nb_rooms + 1}",
      nb_rooms: nb_rooms,
      surface: rand(9..12) + (nb_rooms * rand(15..21)),
      furnished: [true, false].sample,
      description: "Very nice flat with awesome view!"
    )

    # Creating pending rental for each flat
    rental = Rental.create!(
      flat: flat,
      tenant: nil,
      description: "A great flat, which is available!",
      start_date: Date.today,
      pending: true,
      initial_rent: rand(13..19) * flat.surface
    )

    # Creating several dossiers for each rental
    rand(2..12).times do
      candidate =  User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: pswd,
        avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
        role: nil
      )
      Dossier.create!(
        rental: rental,
        candidate: candidate,
        start_date: Date.today,
        status: ["not_selected","to_improve","ok_for_visit"].sample,
        monthly_revenues: rand(12..50) * 100
      )
    end
  end

  #########################################################################
  # 2. DEMO DAY - Creating a flat with a pending rental (and applications)
  #########################################################################

  addresses_2.each do |address|
    flat = Flat.create!(
      address: address,
      owner: user,
      #NB: important to write "owner" and not to use "owner_id"
      to_rent: true,
      # NOTE REALLY USED!
      a_type: "T3",
      nb_rooms: 2,
      surface: 60,
      furnished: true,
      description: "Very nice flat with awesome view!"
    )

    # Creating pending rental for the flat
    rental = Rental.create!(
      flat: flat,
      tenant: nil,
      description: "A great flat, which is available now!",
      start_date: Date.today,
      pending: true,
      initial_rent: 800,
    )

    #--------------------------------------------------#
    # Creating several dossiers for the pending rental #
    #--------------------------------------------------#
    

    ######## 3 DOSSIERS "OK FOR VISIT" ########

    #---------------  1  ---------------#
    candidate =  User.create!(
      first_name: "Maria",
      last_name: "Rena",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face10",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "ok_for_visit",
      monthly_revenues: 2400,
      identity_proof: "fake_url",
      revenues_proof: "fake_url",
      tax_proof: "fake_url"
    )

    #---------------  2  ---------------#
    candidate =  User.create!(
      first_name: "Martin",
      last_name: "Dufort",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "ok_for_visit",
      monthly_revenues: 2300,
      identity_proof: "fake_url",
      revenues_proof: "fake_url",
      tax_proof: "fake_url"
    )

    #---------------  3  ---------------#
    candidate =  User.create!(
      first_name: "Joseph",
      last_name: "Toteau",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "ok_for_visit",
      monthly_revenues: 2200,
      identity_proof: "fake_url",
      revenues_proof: "fake_url",
      tax_proof: "fake_url"
    )


    ######## DOSSIERS "TO IMPROVE" ########

    #---------------  1  ---------------#
    candidate =  User.create!(
      first_name: "Benjamin",
      last_name: "Cibieau",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "to_improve",
      monthly_revenues: 2600,
      identity_proof: "fake_url",
      revenues_proof: ["fake_url", nil].sample,
      tax_proof: nil
    )

    #---------------  2  ---------------#
    candidate =  User.create!(
      first_name: "Kevin",
      last_name: "Chat",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "to_improve",
      monthly_revenues: 2500,
      identity_proof: "fake_url",
      revenues_proof: ["fake_url", nil].sample,
      tax_proof: nil
    )


    #---------------  3  ---------------#
    candidate =  User.create!(
      first_name: "Patrica",
      last_name: "Lafond",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "to_improve",
      monthly_revenues: 2400,
      identity_proof: "fake_url",
      revenues_proof: ["fake_url", nil].sample,
      tax_proof: nil
    )

    ######## 3 DOSSIERS "NOT SELECTED" ########

    #---------------  1  ---------------#
    candidate =  User.create!(
      first_name: "Clément",
      last_name: "Aubert",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "not_selected",
      monthly_revenues: 1300,
      identity_proof: "fake_url",
      revenues_proof: ["fake_url", nil].sample,
      tax_proof: "fake_url"
    )

    #---------------  2  ---------------#
    candidate =  User.create!(
      first_name: "Matthieu",
      last_name: "Debosse",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "not_selected",
      monthly_revenues: 1100,
      identity_proof: "fake_url",
      revenues_proof: ["fake_url", nil].sample,
      tax_proof: "fake_url"
    )

    #---------------  3  ---------------#
    candidate =  User.create!(
      first_name: "Vincent",
      last_name: "Menon",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "not_selected",
      monthly_revenues: 1000,
      identity_proof: "fake_url",
      revenues_proof: ["fake_url", nil].sample,
      tax_proof: nil
    )

    #---------------------------#
    # Creating previous rentals #
    #---------------------------#

    ####### RENTAL N-1 #######

    candidate =  User.create!(
      first_name: "Cécile",
      last_name: "Janin",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )

    rental = Rental.create!(
      flat: flat,
      tenant_id: candidate.id,
      description: "A great flat!",
      start_date: Date.today - 365,
      end_date: Date.today,
      pending: false,
      initial_rent: 730,
    )

    ####### RENTAL N-2 #######

    candidate =  User.create!(
      first_name: "Andrew",
      last_name: "Chen",
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )
    rental = Rental.create!(
      flat: flat,
      tenant_id: candidate.id,
      description: "A great flat!",
      start_date: Date.today - 2*365,
      end_date: Date.today - 365,
      pending: false,
      initial_rent: 720,
    )

end

  ###################################################################
  # 3. FAKER - Creating flats with pending rentals (and applications)
  ###################################################################

addresses_3.each do |address|

    flat = Flat.create!(
      address: address,
      owner: user,
      #NB: important to write "owner" and not to use "owner_id"
      to_rent: true,
      # NOTE REALLY USED!
      a_type: "T#{2 + 1}",
      nb_rooms: 2,
      surface: 48,
      furnished: true,
      description: "Very nice flat with awesome view!"
    )


    # Initialization: creation of a rental and a candidate
    rental = Rental.create!(
      flat: flat,
      tenant: nil,
      description: "A great flat, which is now rented!",
      start_date: Date.today,
      pending: false,
      initial_rent: 720
    )

    candidate =  User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )

    dossier = Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "visiting",
      monthly_revenues: rand(26..40) * 100,
      identity_proof: "fake_url",
      revenues_proof: "fake_url",
      tax_proof: "fake_url",
    )

    # Contractualization: change status of rental and candidate
    dossier.update!(status: "contracted")
    rental.update!(tenant_id: candidate.id, pending: false)
    flat.update!(to_rent: false)

    # Tenant is now about to leave! Flat is now to re-rent!
    flat.update!(to_rent: true)
  end

  ##################################################################
  # 4. FAKER - Creating flats which are already rented
  ##################################################################

  addresses_4.each do |address|
    nb_rooms = rand(2..4)
    flat = Flat.create!(
      address: address,
      owner: user,
      #NB: important to write "owner" and not to use "owner_id"
      to_rent: true,
      # NOTE REALLY USED!
      a_type: "T#{nb_rooms + 1}",
      nb_rooms: nb_rooms,
      surface: nb_rooms * rand(15..21),
      furnished: true,
      description: "Very nice flat with awesome view!"
    )


    # Initialization: creation of a rental and a candidate
    rental = Rental.create!(
      flat: flat,
      tenant: nil,
      description: "A great flat, which is now rented!",
      start_date: Date.today,
      pending: false,
      initial_rent: rand(13..19) * flat.surface
    )

    candidate =  User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: pswd,
      avatar_url: "http://res.cloudinary.com/dtwpyokni/image/upload/c_crop,g_face,r_max/c_scale,w_200/v1/Faces/face#{rand(2..12)}",
      role: nil
    )

    dossier = Dossier.create!(
      rental: rental,
      candidate: candidate,
      start_date: Date.today,
      status: "visiting",
      monthly_revenues: rand(26..40) * 100,
      identity_proof: "fake_url",
      revenues_proof: "fake_url",
      tax_proof: "fake_url",
    )

  # Contractualization: change status of rental and candidate
    dossier.update!(status: "contracted")
    rental.update!(tenant_id: candidate.id, pending: false)
    flat.update!(to_rent: false)

  end

########### ISSUE: need to allocate a candidate to a flat (as tenant)

end

puts separator
puts "Seed is finished ;-)"
puts separator
