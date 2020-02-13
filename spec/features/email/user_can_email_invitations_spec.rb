require 'rails_helper'

RSpec.describe 'Users can send invitations' do
  it "from their dashboard if the github user exists", :vcr do
    user = create(:user, login: 'sender', token: ENV['JORDANS_GITHUB'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    
    fill_in :github_handle, with: 'jordanholtkamp'
    
    expect do
      click_button 'Send an Invite'
    end.to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(page).to have_content("Successfully sent invite!")
  end

  it 'but not if the username is invalid', :vcr do
    user = create(:user, token: ENV['JORDANS_GITHUB'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    fill_in :github_handle, with: 'not_a_github_name'

    click_button 'Send an Invite'

    expect(page).to have_content('Github user not found.')
  end

  it 'tells you if the github user does not have an email', :vcr do
    user = create(:user, token: ENV['JORDANS_GITHUB'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    
    fill_in :github_handle, with: 'LainMcGrath'
    
    click_button 'Send an Invite'

    expect(page).to have_content('This user did not have an email on Github.')
  end
end