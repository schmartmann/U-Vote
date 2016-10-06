require 'csv'
require 'faker'

School.destroy_all

CSV.foreach("./UniData2015Sanitized.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  School.create(row.to_hash)

end

puts "Created #{School.count} schools"
puts "Created #{User.count} users"
