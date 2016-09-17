require 'csv'
require 'faker'

School.destroy_all

CSV.foreach("./UniDataSanitized.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
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

puts "Created #{School.count} schools"
puts "Created #{User.count} users"
