require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "can see bookmarks" do
    tutorial = Tutorial.create(title: 'Tutorial 1', description: 'Tutorial 1', thumbnail: 'image.jpg')
    video = Video.create(title: 'Video 1', description: 'Watch Video 1', thumbnail: "puppy.jpg", tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    tutorial_1 = Tutorial.create(title: 'Tutorial 2', description: 'Tutorial 2', thumbnail: 'image.jpg')
    video = Video.create(title: 'Video 2', description: 'Watch Video 2', thumbnail: "puppy.jpg", tutorial_id: tutorial_1.id)
    visit tutorial_path(tutorial_1)

    click_on 'Bookmark'

    visit dashboard_path

    within "#bookmarks" do
      expect(page).to have_content("Title: Tutorial 1")
      expect(page).to have_content("Description: Watch Video 1")
      expect(page).to have_content("Title: Tutorial 2")
      expect(page).to have_content("Description: Watch Video 2")
    end
  end
end
