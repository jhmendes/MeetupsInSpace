require 'spec_helper'

# As a user
# I want to see who has already joined a meetup
# So that I can see if any of my friends have joined
# Acceptance Criteria:
#
# On a meetup's show page, I should see a list of the members that have joined the meetup.
# I should see each member's avatar and username.

feature "user views members of a meetup group" do

  scenario "user successfully views meetup group members" do
    mynewmeetup = Meetup.create!({
        name: "Rubyists", description: "Come chat Ruby with other developers!",
        location: "Hartford, CT", creator: "jmendes"
      })
    user = FactoryGirl.create(:user, username: "jmendes")
    user1 = FactoryGirl.create(:user, username: "Launcher1")
    user2 = FactoryGirl.create(:user, username: "Launcher2")

    membership1 = Membership.create(user_id: user1.id, meetup_id: mynewmeetup.id)
    membership2 = Membership.create(user_id: user2.id, meetup_id: mynewmeetup.id)

    visit '/'
    sign_in_as user
    click_link "Rubyists"

    expect(page).to have_content "Rubyists Location: Hartford, CT Creator: jmendes
    Description: Come chat Ruby with other developers!"
    expect(page).to have_content "Members: Launcher1 Launcher2"

  end
end
