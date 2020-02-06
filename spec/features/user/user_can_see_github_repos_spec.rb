require 'rails_helper'

feature 'User show page' do
  scenario 'can login to github', :vcr do
    user = create(:user, token: ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_css(".github-repos", count: 5)
  end

  scenario 'user only sees their own repos', :vcr do
    user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    expect(page).to have_link("csv_example")
    expect(page).to have_link("ruby-battleship")
    expect(page).to have_link("activerecord-obstacle-course")
    expect(page).to have_link("adopt_dont_shop")
    expect(page).to have_link("backend_module_0_capstone")
  end

  scenario 'user only sees their own repos pt 2', :vcr do
    user_2 = create(:user, token: ENV['JORDANS_GITHUB'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit dashboard_path

    expect(page).to have_link("activerecord-obstacle-course")
    expect(page).to have_link("adopt_dont_shop")
    expect(page).to have_link("backend_module_0_capstone")
    expect(page).to have_link("battleship")
    expect(page).to have_link("black_thursday_lite")

  end
end
