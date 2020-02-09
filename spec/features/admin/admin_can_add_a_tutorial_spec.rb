require 'rails_helper'

RSpec.feature 'Admin can add a new tutorial' do
#   When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# Be uploaded in image formats such as JPG, GIF, or PNG.
# Remain under the 2MB limit.
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
  it 'Can create a new tutorial' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    #replace with path name
    visit '/admin/tutorials/new'

    title = 'Marvin'
    description = 'Paranoid Android'
    thumbnail = 'https://www.dogfoodadvisor.com/wp-content/uploads/2018/06/small-breed-puppy-470.jpg'

    fill_in 'Title', with: title
    fill_in 'Description', with: description
    fill_in 'Image', with: thumbnail
    click_on("Create new tutorial")

    tutorial = Tutorial.last
    expect(current_path).to eq("/admin/tutorials/#{tutorial.id}")
    expect(page).to have_content('Tutorial successfully created')
  end
end
