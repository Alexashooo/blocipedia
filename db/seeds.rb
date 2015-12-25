(0..50).each do
   password=Faker::Internet.password
   @u=User.create!(
   name: Faker::Name.name,
   email: Faker::Internet.email,
   password: password
   )
end

users=User.all

@users_ids=[]
users.each do |us|
  @users_ids << us.id
end

puts "#{User.count} users created"

(0..200).each do
   @i=Wiki.create!(
   title: Faker::Lorem.sentence,
   body: Faker::Lorem.sentence,
   user_id: @users_ids.sample
   )
end

puts "#{Wiki.count} wikis created"
