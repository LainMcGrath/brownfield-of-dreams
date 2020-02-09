require 'rails_helper'

RSpec.describe "An admin can delete a tutorial" do
  it "can delete tutorials" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    tutorial = create(:tutorial)
    tutorial_1 = create(:tutorial)

    visit admin_dashboard_path

    within "#tutorial-#{tutorial_1.id}" do
      click_on "Destroy"
    end

    expect(page).to have_content("Deleted tutorial")
    expect(current_path).to eq(admin_dashboard_path)
  end
end
