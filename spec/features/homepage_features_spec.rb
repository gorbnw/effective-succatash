require "rails_helper"

feature "searching a business" do
  scenario "the user visits homepage and searches for a business" do
    business_search = "beer"
    city_search = "Seattle"

    visit '/'

    fill_in "search[term]", with: "beer"
    fill_in "search[location]", with: "Seattle"

    click_button "commit"

    expect(page).to render()
  end
end
