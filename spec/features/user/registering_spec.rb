require 'rails_helper'

RSpec.describe "Registration" do
  it "User can register" do

    visit register_path

    email = 'billy@gmail.com'

    fill_in :user_email, with: email
    fill_in :user_first_name, with: 'Billy'
    fill_in :user_last_name, with: 'Bob'
    fill_in :user_password, with: 'secret'
    fill_in :user_password_confirmation, with: 'secret'

    click_on 'Create Account'

    expect(current_path).to eq(dashboard_path)
  end

  xit "cannot register with an already existing email" do
    # visit register_path
    #
    email = 'billy@gmail.com'
    #
    # fill_in :user_email, with: email
    # fill_in :user_first_name, with: 'Billy'
    # fill_in :user_last_name, with: 'Bob'
    # fill_in :user_password, with: 'secret'
    # fill_in :user_password_confirmation, with: 'secret'
    #
    # click_on 'Create Account'
    #
    # expect(current_path).to eq(dashboard_path)
    #

    user = User.create(email: email, first_name: 'Billy', last_name: 'Bob', password_digest: 'secret')
    visit register_path

    fill_in :user_email, with: email
    fill_in :user_first_name, with: 'Billy'
    fill_in :user_last_name, with: 'Bob'
    fill_in :user_password, with: 'secret'
    fill_in :user_password_confirmation, with: 'secret'

    click_on 'Create Account'

    expect(page).to have_content('Username already exists')
    expect(current_path).to eq(register_path)
  end
end
