<<<<<<< HEAD
require 'csv'
require 'faker'

School.destroy_all

CSV.foreach("./lib/seeds/dummy.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  School.create(row.to_hash)

end

status = ["Am I Registered?", "I've Registered", "I Need to Register"]


20.times do
  u1 = User.create(
    email: Faker::Internet.email,
    domain: Faker::Internet.domain_name,
    status: status[rand(3)]
    )
end
=======
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
>>>>>>> 6ced3b5539d646129967fee16c544021c52fafb0
