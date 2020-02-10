require 'rails_helper'

RSpec.feature 'Visitor on the tutorial index page' do
  before :each do
    @prework_tutorial = Tutorial.create!({
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>false
    })
    
    @m1_tutorial = Tutorial.create!({
      "title"=>"Back End Engineering - Module 1",
      "description"=>"Videos related to Mod 1.",
      "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
      "classroom"=>true
    })
  
    @m3_tutorial = Tutorial.create!({
      "title"=>"Back End Engineering - Module 3",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>false,
      "tag_list"=>["Internet", "BDD", "Ruby"],
    })
  end

  scenario 'cannot see a tutorial if it is classroom content on the root path or tutorials index' do
    visit root_path
    
    expect(page).to have_css(".tutorial", count: 2)

    visit tutorials_path

    expect(page).to have_css(".tutorial", count: 2)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    
    expect(page).to have_css(".tutorial", count: 3)

    visit tutorials_path

    expect(page).to have_css(".tutorial", count: 3)
  end

  scenario 'cannot visit a tutorial show page that is classroom content and they are not logged in' do
    visit tutorial_path(@m1_tutorial)

    expect(page).to have_content("The page you were looking for doesn't exist")

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(@m1_tutorial)

    expect(page).to_not have_content("The page you were looking for doesn't exist")
    expect(page).to have_content("Back End Engineering - Module 1")
  end
end