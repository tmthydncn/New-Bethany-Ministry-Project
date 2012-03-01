# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all 


User.create(name: "Maytee Chinavam2", 
email: "chinavam2@lafayette.edu", 
#password_digest: "$2a$10$VLGsuoNKMGqwwqB4QvbLeuH1nd2B/9ddUn6oXISzuUVj301TcSNVq", 
#remember_token: "2ga59vUVmmAI09SMwR8dMQ", 
password:"123456",
password_confirmation: "123456")

User.create(name: "Maytee Chinavam", 
email: "chinavam@lafayette.edu", 
#password_digest: "$2a$10$VLGsuoNKMGqwwqB4QvbLeuH1nd2B/9ddUn6oXISzuUVj301TcSNVq", 
#remember_token: "2ga59vUVmmAI09SMwR8dMQ", 
password:"123456",
password_confirmation: "123456",
admin: true)