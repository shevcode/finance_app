# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
100.times do
    Operation.create(
        amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
        odate: Faker::Date.backward(days: 30),
        description: Faker::Food.dish,
        category_id: Faker::Number.between(from: 1, to: 5),
        otype_id: 2
        # Faker::Number.between(from: 1, to: 2)
    )
end