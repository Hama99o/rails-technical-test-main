require 'rails_helper'

describe "Pokemons", type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  describe "index" do
    let!(:pokemons) { create_list(:pokemon, 20)}
    let!(:pikachu) { create(:pokemon, name: "Pikachu") }
    let!(:charmander) { create(:pokemon, name: "Charmander") }
    let!(:squirtle) { create(:pokemon, name: "Squirtle") }

    before do
      visit(pokemons_path)
      user.pokemons << [pokemons, pikachu, charmander, squirtle]
    end

    it "has the right titles" do
      within('h3') do
        expect(page).to have_content('Pokemons')
      end
    end

    it "User can view and interact with the table" do
      # Visit the pokemons index page
      visit user_pokemons_path

      # Ensure that the table is rendered correctly
      expect(page).to have_css("#index_pokemon")
      expect(page).to have_selector("tbody#index_pokemon tr", count: 23)

      # Ensure that each pokemon's name, price, last_sell_price, and owner is displayed in the table
      pokemons.each do |pokemon|
        expect(page).to have_content(pokemon.name)
        expect(page).to have_content(pokemon.price)
        expect(page).to have_content(pokemon.last_sell_price)
        expect(page).to have_content(pokemon.user.first_name)
        expect(page).to have_content(pokemon.user.last_name)
      end
    end

    it "searches for a pokemon by name" do
      visit user_pokemons_path

      # fill in the search input with "Pikachu" and submit the form
      fill_in "search", with: "Pikachu"
      click_button "search_button"

      # expect to see only Pikachu in the table
      within("#index_pokemon") do
        expect(page).to have_content("Pikachu")
        expect(page).to have_content("Charmander")
        expect(page).to have_content("Squirtle")
      end
    end
  end
end
