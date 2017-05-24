# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')

# all = Membership.all
# all.delete_all
#
# all = User.all
# all.delete_all
#
# all = Meetup.all
# all.delete_all


user_attributes = [
  {provider: "Pro1", uid: "1", username: "lolwho11", email: "lolwho@aol.com", avatar_url: "http://wizard.gamebanana.com/img/ico/sprays/lol_wut.png"},
  {provider: "Pro2", uid: "2", username: "therabbit9", email: "ilikecarrots@aol.com", avatar_url: "http://i.istockimg.com/file_thumbview_approve/19497750/3/stock-photo-19497750-cute-little-bunny.jpg"},
  {provider: "Pro3", uid: "3", username: "bartaco2", email: "tacobowl@aol.com", avatar_url: "http://scout-site.com/el-super-taco/wp-content/uploads/sites/1753/2015/12/El-Super-Taco-Big-Logo.png"}
]

user_attributes.each do |attributes|
  User.create(attributes)
end

meetup_attributes = [
  {name: "WWE", description: "Discuss all the latest happening with the WWE and its wrestlers", location: "Stamford", creator: "The Rock"},
  {name: "Pythonists", description: "We discuss all things Python", location: "Hartford, CT", creator: "Bob"},
  {name: "Rubyists", description: "We discuss all things Ruby", location: "Boston, MA", creator: "Leo"}
]

meetup_attributes.each do |attributes|
  Meetup.create(attributes)
end

membership_attributes = [
  {user_id: 1, meetup_id: 1},
  {user_id: 2, meetup_id: 2},
  {user_id: 3, meetup_id: 3}
]

membership_attributes.each do |attributes|
  Membership.create(attributes)
end
