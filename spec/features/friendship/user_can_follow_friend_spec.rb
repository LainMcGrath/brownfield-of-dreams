require 'rails_helper'

RSpec.describe "User can add friend", :vcr do
  before(:each) do
    @user = create(:user, token: ENV['GITHUB_TOKEN'])
    @user_2 = create(:user, token: ENV['JORDANS_GITHUB'], uid: 53549145)

    @follower = FollowerFacade.new({ 'login' => 'User', 'html_url' => 'google.com', 'id' => 53549145})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    page.set_rack_session(github: @user.email)
  end

  it "if follower has token in database" do

    visit dashboard_path

    within "#request-#{@follower.id}" do
      click_button('Friend')
    end

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("You are now friends with jordanholtkamp")
    within "#request-#{@follower.id}" do
      expect(page).to_not have_button("Friend")
    end
  end

  it "if following has token in database" do

    visit dashboard_path

    within "#request_following-#{@follower.id}" do
      click_button('Friend')
    end

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("You are now friends with jordanholtkamp")

    within "#request_following-#{@follower.id}" do
      expect(page).to_not have_button("Friend")
    end
  end

  it "and see the friend in the added friends section" do
    visit dashboard_path

    within "#request_following-#{@follower.id}" do
      click_button('Friend')
    end

    within "#friendships" do
      expect(page).to have_content("jordanholtkamp")
    end
  end
end
