require 'spec_helper'
#
# As a user
# I want to view a list of all available meetups
# So that I can get together with people with similar interests

# Acceptance Criteria:
#
# On the meetups index page, I should see the name of each meetup.
# Meetups should be listed alphabetically.

feature "User visits home page and sees all meetups listed" do



  scenario "user successfuly visits home page and sees all meetups listed alphabettically" do
    mynewmeetup = Meetup.create!({
        name: "Rubyists", description: "Come chat Ruby with other developers!",
        location: "Hartford, CT", creator: "Bob"
      })

      myothermeetup = Meetup.create!({
          name: "Pythonists", description: "Come chat Python with other developers!",
          location: "Hartford, CT", creator: "John"
        })

    visit '/'

    expect(page).to have_content "Pythonists Rubyists"
  end
end
