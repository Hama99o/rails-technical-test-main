
require 'rails_helper'

describe 'Landing Page', type: :feature do
  let!(:pokemons) { create_list(:pokemon, 20)}

  it 'User visits the landing page' do
    visit root_path

    expect(page).to have_content('Welcome to the Pokemons app!')
    expect(page).to have_content('Discover the world of Pokemons and join our community of')
    expect(page).to have_content(User.count)

    if User.count > 0
      expect(page).to have_css('.user-info')
      within('.user-info') do
        expect(page).to have_css('.user')
        within('.user') do
          expect(page).to have_css('h3')
          expect(page).to have_content('Random User:')
          expect(page).to have_css('p', count: 2)
          expect(page).to have_content('Email:')
          expect(page).to have_content('Pokemons:')
        end
      end
    else
      expect(page).not_to have_css('.user-info')
    end

    expect(page).to have_link('Start', href: pokemons_path)
  end
end