# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
Event.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('events')
Participation.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('participations')

10.times do 
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Hipster.paragraph,
    email: Faker::Lorem.word + '@yopmail.com',
    password: "123456"
  )
  
end

def generate_title
  title = Faker::Movie.title
  while title.length < 5 || title.length > 140
    title = Faker::Movie.title
  end
  title
end

10.times do
  Event.create!(
    start_date: Faker::Time.between(from: Time.current, to: 1.year.from_now),
    duration: Faker::Number.number(digits: 2).to_i * 5,
    title: generate_title,
    description: Faker::ChuckNorris.fact,
    price: Faker::Number.between(from: 1, to: 1000),
    location: Faker::Address.city,
    admin: User.all.sample
  )
end

10.times do 
  participation = Participation.create!(
    user: User.all.sample,
    event: Event.all.sample
  )
end