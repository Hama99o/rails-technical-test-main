require 'rails_helper'

describe "Login", type: :feature do
  let(:user) { create(:user, password: password) }
  let(:password) { 'password' }

  context "with valid credentials" do
    it "Login with valid credentials works" do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      within('h1') do
        expect(page).to have_content('Welcome to the Pokemons app!')
      end
    end
  end
end
