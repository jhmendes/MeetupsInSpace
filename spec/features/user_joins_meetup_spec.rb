require 'spec_helper'

# As a user
# I want to join a meetup
# So that I can partake in this meetup

# Acceptance Criteria:
#
# On a meetup's show page, there should be a button to join the meetup if I am not
# signed in or if I am signed in, but I am not a member of the meetup.
# If I am signed in and I click the button, I should see a message that says
# that I have joined the meetup and I should be added to the meetup's members list.

# If I am not signed in and I click the button, I should see a message which says that I must sign in.

feature "user can join a meetup group" do



  scenario "user successfully joins a meetup group" do
    mynewmeetup = Meetup.create!({
        name: "Rubyists", description: "Come chat Ruby with other developers!",
        location: "Hartford, CT", creator: "jmendes"
      })
    user = FactoryGirl.create(:user, username: "jmendes")


    membership = Membership.create(user_id: user.id, meetup_id: mynewmeetup.id)


    visit '/'
    sign_in_as user
    click_link "Rubyists"
    click_button('Join This Meetup')
    expect(page).to have_content "You've successfully joined this meetup! Welcome to the group."
    expect(page).to have_content "Signed in as jmendes"

  end


  scenario "user unsuccessfully joins a meetup group because they are not signed in" do
    mynewmeetup = Meetup.create!({
        name: "Rubyists", description: "Come chat Ruby with other developers!",
        location: "Hartford, CT", creator: "jmendes"
      })
    user = FactoryGirl.create(:user, username: "jmendes")


    membership = Membership.create(user_id: user.id, meetup_id: mynewmeetup.id)
    visit '/'
    click_link "Rubyists"
    click_button('Join This Meetup')
    expect(page).to have_content "You must be signed in to join this group"
  end

end
