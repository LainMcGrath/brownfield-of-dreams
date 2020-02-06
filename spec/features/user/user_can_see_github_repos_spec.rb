require 'rails_helper'

feature 'User show page' do
  scenario 'can login to github', :vcr do
    user = create(:user, token: ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_css(".github-repos", count: 5)
  end
end