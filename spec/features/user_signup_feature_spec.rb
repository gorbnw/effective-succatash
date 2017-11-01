require 'rails_helper'

feature "visiting the user sign up page" do
  before(:each) do
    visit "/users/sign_up"
  end

  scenario "The user signs up with a username, email, and password, confirming their password" do
    fill_in "user[username]", with: "SpadesMaster"
    fill_in "user[email]", with: "spades@example.com"
    fill_in "user[password]", with: "fakePa$$w0rds"
    fill_in "user[password_confirmation]", with: "fakePa$$w0rds"

    expect { click_on("Sign up") }.to change{ User.count }.by 1
  end

  scenario "The user tries to sign up without a username" do
    fill_in "user[email]", with: "spades@example.com"
    fill_in "user[password]", with: "fakePa$$w0rds"
    fill_in "user[password_confirmation]", with: "fakePa$$w0rds"

    click_on("Sign up")

    expect(page).to have_content("Username can't be blank")
  end

  scenario "The user tries to sign up without an email" do
    fill_in "user[username]", with: "SpadesMaster"
    fill_in "user[password]", with: "fakePa$$w0rds"
    fill_in "user[password_confirmation]", with: "fakePa$$w0rds"

    click_on("Sign up")

    expect(page).to have_content("Email can't be blank")
  end

  scenario "The user tries to sign up without matching passwords" do
    fill_in "user[username]", with: "SpadesMaster"
    fill_in "user[email]", with: "spades@example.com"
    fill_in "user[password]", with: "fakePa$$w0rds"
    fill_in "user[password_confirmation]", with: "fakePasswords"

    click_on("Sign up")

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "the user clicks on the user login link" do
    click_link("Log in")
    expect(page).to have_current_path("/users/sign_in")
  end
end
