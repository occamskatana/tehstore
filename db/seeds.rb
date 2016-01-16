# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)








20.times do users = User.create(

	email: Faker::Internet.email,
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	street: Faker::Address.street_address,
	city: Faker::Address.city,
	zip_code: Faker::Address.zip_code,
	country: Faker::Address.country,
	phone_number: Faker::PhoneNumber.phone_number,
	password: "helloworld"

	) 

end


users = User.all






50.times do items = Item.create(

	title: Faker::Hipster.word,
	public_description: Faker::Hipster.sentences(10),
	internal_description: Faker::Lorem.sentences(3),
	sale_price: Faker::Number.between(1,500000),
	purchase_price: Faker::Number.between(1,500000),
	store_name: Faker::Hipster.word,
	street_address: Faker::Address.street_address,
	city: Faker::Address.city,
	state: Faker::Address.state,
	zip: Faker::Address.zip_code,
	country: Faker::Address.country,
	user: users.sample,
	tag_list: Faker::Hipster.words(5)
	)
end

items = Item.all 


puts "#{User.count} users now in the database"
puts "#{Item.count} items now in the database"