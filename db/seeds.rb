# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
businesses = ["beer-star-seattle-2", "the-beer-junction-seattle", "redhook-brewlab-seattle", "hill-city-tap-house-and-bottle-shop-seattle", "cloudburst-brewing-seattle", "seattle-beer-co-seattle-7", "teku-tavern-seattle", "old-stove-brewing-seattle", "fremont-brewing-seattle-3", "chucks-hop-shop-seattle-2", "georgetown-brewing-company-seattle", "queen-anne-beerhall-seattle", "ounces-taproom-and-beer-garden-seattle", "swel-seattle", "standard-brewing-seattle", "optimism-brewing-company-seattle", "ballard-beer-company-seattle", "perihelion-brewery-seattle", "figurehead-brewing-seattle"]

tags = ['Unkind Staff', 'Accessible Space', 'Gender-neutral bathrooms', 'Harrassment', "Unresponsive Staff", "Accomodating Staff", "Accomodating Patrons", "Other-Abled Friendly"]

tags.each do |tag|
  Tag.create(description: tag)
end


40.times do
  user_info = {
    username: Faker::Lovecraft.words(2, false).join,
    email: Faker::Internet.email,
    password: "hamham"
  }
  User.create(user_info)
end

120.times do
  t = Testimonial.create(
    user: User.all.sample,
    anonymous: Faker::Boolean.boolean(0.4),
    positive: Faker::Boolean.boolean(0.5),
    description: Faker::Lorem.paragraph(2, true, 6),
    yelp_id: businesses.sample
  )

  t.tags << Tag.all.sample

end
