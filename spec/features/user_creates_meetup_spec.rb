require 'spec_helper'
# As a user
# I want to create a meetup
# So that I can gather a group of people to do an activity

# Acceptance Criteria:
#
# There should be a link from the meetups index page that takes you to the meetups new page.
# On this page there is a form to create a new meetup.
# I must be signed in, and I must supply a name, location, and description.
# If the form submission is successful, I should be brought to the meetup's show page,
# and I should see a message that lets me know that I have created a meetup successfully.
# CONTINUE HERE!

# If the form submission is unsuccessful, I should remain on the meetups new page,
# and I should see error messages explaining why the form submission was unsuccessful.
# The form should be pre-filled with the values that were provided when the form was submitted.

feature "user creates meetup group" do

  scenario "user successfully creates meetup group" do

    user = FactoryGirl.create(:user, username: "jmendes")


    visit '/'
    sign_in_as user
    click_link "Create New Meetup"
    fill_in('Name', with: 'CT Web Developers')
    fill_in('Location', with: 'Hartford, CT')
    fill_in('Description', with: 'Join a community of Web Developers from Connecticut')
    click_button('Create Meetup')
    expect(page).to have_content("Signed in as jmendes")
    expect(page).to have_content("CT Web Developers Location: Hartford, CT Creator: jmendes
    Description: Join a community of Web Developers from Connecticut")
    expect(page).to have_content("You've successfully created a meetup!")

  end

  scenario "user is unsuccessful in creating a meetup" do
    user = FactoryGirl.create(:user, username: "jmendes")

    visit '/'
    sign_in_as user
    click_link "Create New Meetup"
    # user doesn't fill in any information and just tries to submit
    click_button('Create Meetup')
    expect(page).to have_content("Name can't be blank Location can't be blank Description can't be blank")
  end

  scenario "user is unsuccessful in creating a meetup and partially fills in information" do
      user = FactoryGirl.create(:user, username: "jmendes")

    visit '/'
    sign_in_as user
    click_link "Create New Meetup"
    fill_in('Name', with: 'CT Web Developers')
    click_button('Create Meetup')
    expect(page).to have_content("Location can't be blank Description can't be blank")

  end

end
