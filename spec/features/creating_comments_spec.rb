require 'spec_helper'

feature "Creating comments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }
  let!(:state) { FactoryGirl.create(:state, name: "Open") }
  before do
    define_permission!(user, "view", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
  end
  scenario "Creating a comment" do
    click_link ticket.title
    fill_in "Text", with: "Added a comment!"
    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    within("#comments") do
      expect(page).to have_content("Added a comment!")
    end
  end
  scenario "Creating an invalid comment" do
    click_link ticket.title
    click_button "Create Comment"
    expect(page).to have_content("Comment has not been created.")
    expect(page).to have_content("Text can't be blank")
  end
  scenario "Changing a ticket's state" do
    define_permission!(user, "change states", project)
    click_link ticket.title
    fill_in "Text", with: "This is a real issue"
    select "Open", from: "State"
    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    within(:xpath, '//div[@id="ticket"]/div[@class="state state_open"]') do   #because "#ticket .state" is ambiguous
      expect(page).to have_content("Open")
    end
    within("#comments") do
      expect(page).to have_content("State: Open")
    end
  end
  scenario "A user without permission cannot change the state" do
    click_link ticket.title
    find_element = lambda { find("#comment_state_id") }
    message = "Expected not to see #comment_state_id, but did."
    find_element.should(raise_error(Capybara::ElementNotFound), message)
  end
  scenario "Adding a tag to a ticket" do
    click_link ticket.title
    within("#ticket #tags") do
      expect(page).to_not have_content("bug")
    end
    fill_in "Text", :with => "Adding the bug tag"
    fill_in "Tags", :with => "bug"
    click_button "Create Comment"
    expect(page).to have_content("Comment has been created.")
    within("#ticket #tags") do
      expect(page).to have_content("bug")
    end
  end
end