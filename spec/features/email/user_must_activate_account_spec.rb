require 'rails_helper'

RSpec.describe 'As a new user' do
  describe 'when I register my account' do
    it 'tells me to activate my account from my email' do
      visit register_path

      email = 'billy@gmail.com'

      fill_in :user_email, with: email
      fill_in :user_first_name, with: 'Billy'
      fill_in :user_last_name, with: 'Bob'
      fill_in :user_password, with: 'secret'
      fill_in :user_password_confirmation, with: 'secret'

      click_on 'Create Account'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{email}")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
      expect(page).to_not have_content('Account status: Active')
    end

    it 'sends me an email with a link to activate my account' do
      visit register_path

      email = 'billy@gmail.com'

      fill_in :user_email, with: email
      fill_in :user_first_name, with: 'Billy'
      fill_in :user_last_name, with: 'Bob'
      fill_in :user_password, with: 'secret'
      fill_in :user_password_confirmation, with: 'secret'

      expect do
        click_on 'Create Account' 
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
      
      user = User.last
      visit "/activate/users/#{user.id}"

      expect(current_path).to eq(dashboard_path)

      flash = 'Thanks for activating buddy :)'

      expect(page).to have_content(flash)
      expect(page).to have_content('Account status: Active')
    end
  end
end