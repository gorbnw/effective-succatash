require 'rails_helper'

feature "visiting the homepage" do
  before(:each) do
    visit "/"
  end

  scenario "the user clicks on the user sign-up link" do
    click_link("Sign Up")
    expect(page).to have_current_path("/users/sign_up")
  end

  scenario "the user clicks on the user login link" do
    click_link("Log In")
    expect(page).to have_current_path("/users/sign_in")
  end

  scenario "the user can search for a business" do
    fill_in "search[term]", with: "beer"
    fill_in "search[location]", with: "Seattle"

    click_on("Search")

    expect(page).to have_content("Businesses")
  end

  scenario "error is raised when the user does not fill in a city" do
    fill_in "search[term]", with: "beer"

    click_on("Search")

    expect(page).to have_content("Please enter a city to search")
  end
end
