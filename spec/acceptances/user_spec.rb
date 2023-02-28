require 'rails_helper'

RSpec.describe 'User profile page', type: :feature do
  let(:user) { create(:user) }
  let(:pokemon) { create(:pokemon, price: 10.0) }

  before do
    login_as(user, scope: :user)
    user.pokemons << [pokemon, create(:pokemon)]
    visit user_path(user)
  end

  it 'displays user account information' do
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(number_to_currency(user.balance))
  end

  it 'displays user Pokemon information' do
    expect(page).to have_content(user.pokemons.count)
    expect(page).to have_content(number_to_currency(user.balance))
    expect(page).to have_content(number_to_currency(user.pokemons.sum(:price)))
    expect(page).to have_content(number_to_currency(user.net_worth))
  end

  it 'allows user to add money' do
    click_link 'Add Money'
    expect(current_path).to eq(add_money_screen_path)
  end

  it 'allows user to edit their profile' do
    click_link 'Edit Info'
    expect(current_path).to eq(edit_user_registration_path)
  end
end
