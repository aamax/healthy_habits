# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
ActiveRecord::Base.connection.execute("TRUNCATE TABLE users RESTART IDENTITY;")

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.create! :name => "Allen Maxwell", :email => "aamax@xmission.com",
                                    :password => ENV['ADMIN_PASSWORD'].dup,
                                    :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts "User: #{user.name} [#{user.id}]"
user.add_role :admin

user = User.create! :name => "Cathy Maxwell", :email => ENV['CATHY_EMAIL'].dup,
                                    :password => ENV['CATHY_PASSWORD'].dup,
                                    :password_confirmation => ENV['CATHY_PASSWORD'].dup
puts "User: #{user.name} [#{user.id}]"

user.add_role :admin