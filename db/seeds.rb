# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#User.destroy_all
#Event.destroy_all
#GuestList.destroy_all

User.create!([{
  username: "Alice", 
  email: "alice@user.com",
  password: "123456",
  password_confirmation: "123456"
}, 
{
  username: "Bob",
  email: "bob@user.com",
  password: "123456",
  password_confirmation: "123456"
}, 
{
  username: "Charlie",
  email: "charlie@user.com",
  password: "123456",
  password_confirmation: "123456"
}])

Event.create!([{
  event_date: DateTime.new(2023,5,27,0),
  location: "park",
  name: "picnic",
  creator_id: 1,
  event_time: Time.new(2023)
}, 
{
  event_date: DateTime.new(2023,5,1,0),
  location: "town hall",
  name: "city counsil meeting",
  creator_id: 1,
  event_time: Time.new(2023)
}, 
{
  event_date: DateTime.new(2023,6,30,0),
  location: "downtown",
  name: "parade",
  creator_id: 2,
  event_time: Time.new(2023)
}, 
{
  event_date: DateTime.new(2023,5,2,0),
  location: "track",
  name: "preview day",
  creator_id: 2,
  event_time: Time.new(2023)
}
])

GuestList.create!([{
  attended_event_id: 1,
  attendee_id: 1
}, 
{
  attended_event_id: 1,
  attendee_id: 2
},
{
  attended_event_id: 1,
  attendee_id: 3
}, 
{
  attended_event_id: 2,
  attendee_id: 1
}, 
{
  attended_event_id: 2,
  attendee_id: 2
},
{
  attended_event_id: 3,
  attendee_id: 1
}
])