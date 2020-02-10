require 'rails_helper'

RSpec.feature 'Visitor on the tutorial index page' do
  scenario 'cannot see a tutorial if it is classroom content' do
    prework_tutorial = Tutorial.create!({
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>false
    })
    
    m1_tutorial = Tutorial.create!({
      "title"=>"Back End Engineering - Module 1",
      "description"=>"Videos related to Mod 1.",
      "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
      "classroom"=>true
    })

    m3_tutorial = Tutorial.create!({
      "title"=>"Back End Engineering - Module 3",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>false,
      "tag_list"=>["Internet", "BDD", "Ruby"],
    })

    visit root_path
    
    expect(page).to have_css(".tutorial", count: 2)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    
    expect(page).to have_css(".tutorial", count: 3)
  end
end