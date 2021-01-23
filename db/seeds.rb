# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  service_id = Faker::Internet.username(specifier: 6)
  username = Faker::Name.name
  email = Faker::Internet.email
  pass = Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false)
  User.create!(
    service_id: service_id,
    username: username,
    email: email,
    password: pass,
    password_confirmation: pass
  )
end

# User.all.each do |user|
#   content = Faker::Lorem.sentence(word_count: 3)
#   user.microposts.create!(
#     content: content
#   )
#   if Cv.find_by(user_id: user.id) == nil
#     education = Faker::Educator.university 
#     cv = Cv.create!(
#       education: education,
#       user_id: user.id
#     )
#     objective_name = Faker::Job.title
#     cv.objectives.create!(
#       name: objective_name
#     )
#     skill_name = Faker::Job.key_skill
#     cv.skills.create!(
#       name: skill_name
#     )
#   end

#   next_user_id = user.id + 1
#   prev_user_id = user.id - 1 
#   following_next = Relationship.find_by(follower_id: user.id, following_id: next_user_id)
#   following_prev = Relationship.find_by(follower_id: user.id, following_id: prev_user_id)

#   if following_next == nil && (User.find_by(id: user.id + 1) != nil)
#     Relationship.create!(
#       follower_id: user.id,
#       following_id: next_user_id
#     )
#   end
#   if (user.id != 1) && (following_prev == nil)
#     Relationship.create!(
#       follower_id: user.id,
#       following_id: prev_user_id
#     )
#   end

# end