# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Therapist.create!(unique_id: "10101010",
             name: "example",
             password: "password",
             password_confirmation: "password"
)
admin = Therapist.first
admin.add_role :admin

5.times do |n|
  unique_id = "#{n}" * 8
  name = Faker::Name.name
  password = "password"
  Therapist.create!(unique_id: unique_id,
                    name: name,
                    password: password,
                    password_confirmation: password)
end

therapists = Therapist.order(:created_at).take(3)
5.times do
  therapists.each do |therapist|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    therapist.patients.create!(first_name: first_name,
                               last_name: last_name)
  end
end
