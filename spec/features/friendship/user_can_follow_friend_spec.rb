require 'rails_helper'

RSpec.describe "User can add friend", :vcr do
  it "Can add a friend if friend has token in database" do
    user = create(:user, token: ENV['GITHUB_TOKEN'])
    user_2 = create(:user, token: ENV['JORDANS_GITHUB'])
    # user_3 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    page.set_rack_session(github: user.email)

    visit dashboard_path
    
    find(".followers", match: :first).click

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Friend added")
    expect(page).to_not have_button("Friend follower")
  end
end
