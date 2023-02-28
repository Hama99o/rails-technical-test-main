require 'rails_helper'

describe "Add money to wallet", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "User adds money to their wallet" do
    sign_in user
    visit add_money_screen_path

    fill_in "Balance", with: 100
    click_button "Deposit"

    expect(current_path).to eq(user_path)
    expect(page).to have_content("Balance: $100.00")
  end
end