require 'spec_helper'
feature "User profiles" do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    sign_in_as!(user)
    visit user_path(user)
  end
  scenario "Viewing" do
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end
  scenario "Updating" do
    click_link "Edit Profile"
    fill_in "Username", with: "new_username"
    fill_in "Email", with: "new_mail@world.de"
    click_button "Update Profile"
    expect(page).to have_content("Profile has been updated.")
  end
end