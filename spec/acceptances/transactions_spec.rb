require 'rails_helper'

describe "Transaction table", type: :feature do
  let!(:user) { create(:user) }
  let!(:pokemon) { create(:pokemon) }
  let!(:transactions) { create_list(:transaction, 3, user: user, pokemon: pokemon) }

  it "User can see transaction details in a table" do
    # Log in as the user
    sign_in user

    # Navigate to the transaction table page
    visit user_transactions_path

    # Verify the transaction table is displayed
    expect(page).to have_selector("table")
    expect(page).to have_selector("th", text: "Action")
    expect(page).to have_selector("th", text: "Price")
    expect(page).to have_selector("th", text: "Name")

    # Verify the transaction details are displayed in the table
    transactions.each do |transaction|
      expect(page).to have_selector("td", text: transaction.action)
      expect(page).to have_selector("td", text: transaction.amount.to_s)
      expect(page).to have_selector("td", text: transaction.pokemon.name)
    end
  end
end
