# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
10.times do
    Operation.create(
        amount: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        odate: Faker::Date.backward(days: 10),
        description: Faker::Quote.yoda,
        category_id: Faker::Number.between(from: 1, to: 3)
        otype_id: Faker::Number.between(from: 1, to: 2)
    )
end