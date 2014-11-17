# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Collector.create(email: 'melvin@cspmconsulting.com', password: 'cspm2014', password_confirmation: 'cspm2014')
User.create(email: 'melvin@cspmconsulting.com', password: 'cspm2014', password_confirmation: 'cspm2014')

pass = '12345678'
Collector.create!(name: 'Kim Degoul', email: 'kim2@chivasrd.com', password: pass, password_confirmation: pass)
Collector.create!(name: 'Stefanie Muñoz', email: 'stefanie@chivasrd.com', password: pass, password_confirmation: pass)
Collector.create!(name: 'Liliana Valencia', email: 'liliana@chivasrd.com', password: pass, password_confirmation: pass)
Collector.create!(name: 'Enaldi Perez', email: 'enaldi@chivasrd.com', password: pass, password_confirmation: pass)
Collector.create!(name: 'Yanilda Beato', email: 'yanilda@chivasrd.com', password: pass, password_confirmation: pass)
Collector.create!(name: 'Carol Grullon', email: 'carol@chivasrd.com', password: pass, password_confirmation: pass)
Collector.create!(name: 'Recolector Extra', email: 'extra1@chivasrd.com', password: pass, password_confirmation: pass)

User.create!(email: 'jose@chivasrd.com', password: pass, password_confirmation: pass)
User.create!(email: 'ivan@chivasrd.com', password: pass, password_confirmation: pass)
User.create!(email: 'roberto@chivasrd.com', password: pass, password_confirmation: pass)
User.create!(email: 'emmanuel@chivasrd.com', password: pass, password_confirmation: pass)
User.create!(email: 'carlos@chivasrd.com', password: pass, password_confirmation: pass)
User.create!(email: 'johanna@chivasrd.com', password: pass, password_confirmation: pass)
