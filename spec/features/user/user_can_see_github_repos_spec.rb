require 'rails_helper'

feature 'User show page' do
  scenario 'can see show page after logging in' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("#{user.first_name}")
    expect(page).to have_content("#{user.last_name}")
    expect(page).to have_content("#{user.email}")
    expect(page).to_not have_content('GitHub Repositories')
    click_button('Log Out')
    expect(current_path).to eq(root_path)
  end

  # scenario 'can login to github SSO', :vcr do
  #   user = create(:user, token: ENV['GITHUB_TOKEN'])
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #   visit dashboard_path
  #
  #   expect(page).to_not have_content('GitHub Repositories')
  #   stub_omniauth
  #   # require "pry"; binding.pry
  #   click_button('Log in to GitHub')
  #   page.set_rack_session(github: user.email)
  #   expect(current_path).to eq(dashboard_path)
  #   expect(page).to have_content('Github Repositories')
  #   expect(page).to have_css(".github-repos", count: 5)
  # end

  scenario 'user only sees their own repos', :vcr do
    user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
    page.set_rack_session(github: user_1.email)
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
    page.set_rack_session(github: user_2.email)

    visit dashboard_path
    expect(page).to have_link("activerecord-obstacle-course")
    expect(page).to have_link("adopt_dont_shop")
    expect(page).to have_link("backend_module_0_capstone")
    expect(page).to have_link("battleship")
    expect(page).to have_link("black_thursday_lite")
  end
end
