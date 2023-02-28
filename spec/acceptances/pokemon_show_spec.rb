
require 'rails_helper'

describe "Pokemon show page", type: :feature do
  let!(:user) { create(:user, first_name: "Ash", last_name: "Ketchum", email: "ash@pokemon.com") }
  let!(:pokemon) { create(:pokemon, name: "Pikachu", price: 100, user: user) }

  before do
    login_as(user)
  end

  it "displays the Pokemon's details and owner" do
    visit pokemon_path(pokemon)

    expect(page).to have_content("Pokemon: Pikachu")
    expect(page).to have_content("Price: $100.00")
    expect(page).to have_content("Last Sell Price: $0.00")
    expect(page).to have_content("Owner:")
    expect(page).to have_content("Name: Ash Ketchum")
    expect(page).to have_content("Email: ash@pokemon.com")
  end

  context "when the current user owns the Pokemon" do
    let!(:current_user) { create(:user) }

    before do
      login_as(current_user)
      current_user.pokemons << pokemon
    end

    it "displays a form to sell the Pokemon" do
      visit pokemon_path(pokemon)

      expect(page).to have_field("Price", with: "100.0")
      expect(page).to have_button("Sell")
    end
  end

  context "when the current user does not own the Pokemon" do
    let!(:current_user) { create(:user) }

    before { login_as(current_user) }

    it "displays a 'Buy' button" do
      visit pokemon_path(pokemon)

      expect(page).to have_link("Buy")
    end
  end
end
