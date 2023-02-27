require 'rails_helper'

describe "Pokemons", type: :feature do
  let(:user) { create(:user)}
  let!(:pokemons) { create_list(:pokemon, 20)}

  before do
    login_as(user)
  end

  describe "index" do
    before do
      visit(pokemons_path)
    end

    it "has the right titles" do
      within('h3') do
        expect(page).to have_content('Pokemons')
      end
    end
  end
end
