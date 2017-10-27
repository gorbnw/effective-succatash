# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  business_info = {
    name: Faker::Space.constellation,
    phone: "206-867-5309",
    address: Faker::Address.street_address
  }
  Business.create(business_info)
end

40.times do
  user_info = {
    username: Faker::Lovecraft.words(2, false).join,
    email: "ham@ham.ham",
    password: "hamham"
  }
  User.create(user_info)
end

120.times do
  t = Testimonial.create(
    anonymous: Faker::Boolean.boolean(0.4),
    positive: Faker::Boolean.boolean(0.5),
    description: Faker::Lorem.paragraph(2, true, 6)
  )
  User.all.sample.testimonials << t
  Business.all.sample.testimonials << t
end
