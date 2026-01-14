# frozen_string_literal: true

puts "Database: Seeding."

User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.approval_status = :approved
  user.first_name = 'Omar'
  user.password = 'password'
  user.role = 0
  user.longitude = 29.94574969945051
  user.latitude = 31.21465065136636
  user.is_online = true
end

User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.approval_status = :approved
  user.first_name = 'Rashad'
  user.password = 'password'
  user.role = 0
  user.longitude = 29.93344269821699
  user.latitude = 31.223274835326773
  user.is_online = true
end

User.find_or_create_by!(email: 'user5@example.com') do |user|
  user.approval_status = :approved
  user.first_name = 'Fatima'
  user.password = 'password'
  user.role = 0
  user.longitude = 29.923496246337894
  user.latitude = 31.198119005254362
  user.is_online = true
end

User.find_or_create_by!(email: 'user3@example.com') do |user|
  user.approval_status = :approved
  user.first_name = 'John'
  user.password = 'password'
  user.role = 0
  user.longitude = 29.908811
  user.latitude = 31.2096
  user.is_online = true
end

User.find_or_create_by!(email: 'user4@example.com') do |user|
  user.approval_status = :approved
  user.first_name = 'Jane'
  user.password = 'password'
  user.role = 0
  user.longitude = 29.551928
  user.latitude = 30.902412
  user.is_online = true
end

User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.approval_status = :approved
  user.first_name = 'Admin'
  user.password = 'password'
  user.role = 1
  user.longitude = 29.99831
  user.latitude = 31.258994
end

Event.find_or_create_by! title: 'Event 1' do |event|
  event.longitude = 29.921429
  event.latitude = 31.190079
  event.briefing = 'Event 1 briefing'
  event.title = 'Event 1'
end

puts "Database: Seeded."
