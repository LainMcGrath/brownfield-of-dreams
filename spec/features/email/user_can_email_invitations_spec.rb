require 'rails_helper'

RSpec.describe 'Users can send invitations' do
  it "from their dashboard" do
    user = create(:user)
    # follower = FollowerFacade.new({ 'login' => 'User', 'html_url' => 'google.com', 'id' => 53549145})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    # within '#invite-'
  end
end