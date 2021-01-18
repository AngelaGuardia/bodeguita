# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include FactoryBot::Syntax::Methods

Discount.destroy_all
OrderImage.destroy_all
Order.destroy_all
Image.destroy_all
User.destroy_all

sergio = FactoryBot.create(:user, :photographer, first_name: 'Sergio')

pingpong = FactoryBot.create(:image, name: "pingpong", url: 'https://cdn.shopify.com/s/files/1/0069/6149/6154/products/Nestle-Savoy-Ping-Pong-Chocolate-Covered-Peanuts_1920x2400.jpg?v=1582309469', user: sergio, price: 2.0)
ovomaltina = FactoryBot.create(:image, name: "ovomaltina", url: 'https://cdn.shopify.com/s/files/1/0069/6149/6154/products/Ovomaltina-Chocolate-Cream-Tube-Pack-of-4_1920x2400.jpg?v=1582908749', user: sergio, price: 1.0)
samba = FactoryBot.create(:image, name: "samba", url: 'https://cdn.shopify.com/s/files/1/0069/6149/6154/products/Nestle-Savoy-Samba-Strawberry-Wafer-Chocolate-Covered-Pack-of-4_876x1095.jpg?v=1586804876', user: sergio, price: 4.0)

FactoryBot.create(:discount, user: sergio, minimum_quantity: 4, percentage: 0.75)

sofia = FactoryBot.create(:user, :buyer, first_name: 'Sofia')

order = create(:order, user: sofia)

FactoryBot.create(:order_image, order: order, image: pingpong, quantity: 2)
FactoryBot.create(:order_image, order: order, image: ovomaltina, quantity: 2)
FactoryBot.create(:order_image, order: order, image: samba, quantity: 4)
