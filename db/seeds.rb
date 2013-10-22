# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jake = User.create(username: "jake", email: "jake@gmail.com", password_digest: "pass")
favorite = Favorite.create(address: "10 east 21st street, NY, NY", user_id: 2)
