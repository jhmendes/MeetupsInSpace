require 'spec_helper'
# As a user
# I want to view the details of a meetup
# So that I can learn more about its purpose

# Acceptance Criteria:
#
# On the index page, the name of each meetup should be a link to the meetup's show page.
# On the show page, I should see the name, description, location, and the creator of the meetup.
feature "user views details of meetup group" do



  scenario "user successfully views meetup group details" do
    mynewmeetup = Meetup.create!({
        name: "Rubyists", description: "Come chat Ruby with other developers!",
        location: "Hartford, CT", creator: "jmendes"
      })
    user = FactoryGirl.create(:user, username: "jmendes")


    visit '/'
    sign_in_as user
    click_link "Rubyists"

    expect(page).to have_content "Rubyists Location: Hartford, CT Creator: jmendes
    Description: Come chat Ruby with other developers!"
  end
end
