User.find_or_create_by!(email: 'user@example.com') do |user|
  user.first_name = 'User'
  user.password = 'password'
  user.role = 0
end

User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.first_name = 'Admin'
  user.password = 'password'
  user.role = 1
end

puts "Seeded default users."
