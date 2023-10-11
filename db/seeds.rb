# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  Parking.destroy_all
  Car.destroy_all
  Chauffeur.destroy_all
  Rental.destroy_all

  5.times do |n|
    User.create!(
      name: "User#{n+1}",
      email: "user#{n+1}@gmail.com",
      password: "password",
      confirmed_at: Time.now
    )
  end

  User.create!(
    [
      {
        name: "admin",
        email: "admin@gmail.com",
        password: "password",
        password_confirmation: "password",
        admin: true,
        confirmed_at: Time.now
      },
      {
        name: "admin2",
        email: "admin2@gmail.com",
        password: "password",
        password_confirmation: "password",
        admin: true,
        confirmed_at: Time.now
      },
    ]
  )
  
  5.times do |n|
    name = Faker::Company.name
    name_gerant = Faker::Name.name
    city = Faker::Address.city
    email = Faker::Internet.email
    latitude = Faker::Address.latitude
    longitude = Faker::Address.longitude
  
    Parking.create(
      name: name,
      name_gerant: name_gerant,
      city: city,
      email: email,
      latitude: latitude,
      longitude: longitude
    )
  end

  5.times do |n|
    Chauffeur.create(
      name: "Chauffeur #{n + 1}", 
      quartier: "Quartier #{n + 1}", 
      parking: Parking.first,      
      telephone: 12345678 + n 
    )
  end

  5.times do |n|
    car = Car.create(
      numero_matricule: "ABCD#{n + 1}",
      marque: "Marque #{n + 1}",
      modele: "Modèle #{n + 1}",
      car_type: "Type #{n + 1}",
      annee: 2022 + n,
      price_rental: 2000 + n * 100,
      carburant: "Essence",
      disponible: true,
      parking: Parking.first 
    )
  
    car.photo.attach(
      io: File.open(Rails.root.join('public', 'images', "photo#{n + 1}.jpg")),
      filename: "photo#{n + 1}.jpg"
    )

   rental = Rental.create(
      date: Date.today + n.days,
      time: Time.now + n.hours,
      duration: 4 + n,
      destination: "Destination #{n + 1}",
      user: User.first,
      car: car,
      chauffeur: Chauffeur.first
    )

    car.update(disponible: false)

  end

end