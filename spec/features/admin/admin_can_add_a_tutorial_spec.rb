require 'rails_helper'

RSpec.feature 'Admin can add a new tutorial' do
  it 'Can create a new tutorial' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    title = 'Marvin'
    description = 'Paranoid Android'
    thumbnail = 'https://www.dogfoodadvisor.com/wp-content/uploads/2018/06/small-breed-puppy-470.jpg'

    fill_in 'Title', with: title
    fill_in 'Description', with: description
    fill_in 'Thumbnail', with: thumbnail
    click_on('Create new tutorial')

    tutorial = Tutorial.last
    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content('Tutorial successfully created')
  end

  xit "Cannot create a tutorial with missing information" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    title = 'Marvin'
    description = 'Paranoid Android'
    thumbnail = 'https://www.dogfoodadvisor.com/wp-content/uploads/2018/06/small-breed-puppy-470.jpg'

    fill_in 'Title', with: title
    fill_in 'Description', with: description

    click_on('Create new tutorial')
    expect(page).to have_content("Thumbnail cannot be blank")
  end
end
