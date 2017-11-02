require 'rails_helper'

feature "visiting the user sign up page" do
  let!(:user_example_1) { FactoryBot.create(:user) }

  before(:each) do
    visit "/users/sign_in"
  end

  # scenario "When the user successfully logins the user is redirected to the business search page and a session is created" do
  #   fill_in "user[email]", with: user_example_1.email
  #   fill_in "user[password]", with: user_example_1.password
  #
  #   click_on("Log in")
  #
  #   expect(page).to have_current_path("/businesses")
  #   expect(session[:database_authenticatable]).to be true
  # end
end
