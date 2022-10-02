# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create!(name: 'John Doe', email: 'john123@gmail.com', password: 'test123', roles: ['admin'])
user2 = User.create!(name: 'Jane Doe', email: 'jane123@gmail.com', password: 'test123', roles: ['admin'])
user1.confirm
user2.confirm
veh1 = Vehicle.create!(brand: 'BWM', model: 'BMW-30', image: 'image-bmw', price: 80, description: 'good and lightspeed with low consumptiom')
veh2 = Vehicle.create!(brand: 'Macendiz', model: 'Benz-30', image: 'image-Benz', price: 90, description: 'good and lightspeed with low consumptiom')
veh3 = Vehicle.create!(brand: 'G-Wagon', model: 'G-wagon-15', image: 'image-wagon', price: 95, description: 'good and lightspeed with low consumptiom')
res1 = Reservation.create!(user: user1, vehicle: veh1, date: '24-09-2022', city: 'bravos')
res1 = Reservation.create!(user: user2, vehicle: veh1,date: '24-09-2022', city: 'capetown')
res1 = Reservation.create!(user: user2, vehicle: veh3,date: '24-09-2022', city: 'lusaka')
res1 = Reservation.create!(user: user1, vehicle: veh2,date: '24-09-2022', city: 'venice')
