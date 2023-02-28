
require 'rails_helper'


describe PokemonsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:pokemon) { create(:pokemon, user: user) }

  describe "GET index" do
    it "assigns @pokemons" do
      get :index
      expect(assigns(:pokemons)).to eq(Pokemon.all)
    end

    context "when user is signed in" do
      before { sign_in user }

      it "assigns @pokemons excluding user's own pokemon" do
        get :index
        expect(assigns(:pokemons)).to eq(Pokemon.where.not(user_id: user.id))
      end
    end

    context "with search parameter" do
      let!(:search_pokemon) { create(:pokemon, name: "Pikachu") }

      it "assigns @pokemons matching the search parameter" do
        get :index, params: { search: "Pikachu" }
        expect(assigns(:pokemons)).to eq([search_pokemon])
      end
    end
  end

  describe "GET show" do
    it "assigns @pokemon" do
      get :show, params: { id: pokemon.id }
      expect(assigns(:pokemon)).to eq(pokemon)
    end
  end

  describe "GET landing_page" do
    it "renders the landing page" do
      get :landing_page
      expect(response).to render_template(:landing_page)
    end
  end

  describe "POST buy" do
    let(:buyer) { create(:user, balance: pokemon.price + 100) }
    before { sign_in buyer }

    context "when the buyer has enough balance" do
      it "changes pokemon owner, decreases buyer's balance, and creates transaction" do
        post :buy, params: { id: pokemon.id }
        expect(pokemon.reload.user).to eq(buyer)
        expect(buyer.reload.balance).to eq(100)
        expect(Transaction.last.user).to eq(buyer)
        expect(Transaction.last.pokemon).to eq(pokemon)
        expect(Transaction.last.action).to eq("buy")
        expect(Transaction.last.amount).to eq(pokemon.price)
        expect(response).to redirect_to(user_pokemons_path)
      end
    end

    context "when the buyer does not have enough balance" do
      let(:buyer) { create(:user, balance: pokemon.price - 100) }

      it "does not change pokemon owner and redirects to pokemon show page with error message" do
        post :buy, params: { id: pokemon.id }
        expect(pokemon.reload.user).to eq(user)
        expect(buyer.reload.balance).to eq(pokemon.price - 100)
        expect(Transaction.count).to eq(0)
        expect(flash[:error]).to eq("You don't have enough balance to buy #{pokemon.name}.")
        expect(response).to redirect_to(pokemon_path(pokemon))
      end
    end
  end

  describe "POST sell" do
    let(:seller) { create(:user, balance: 100) }
    let(:buyer) { create(:user, balance: 100) }
    let(:pokemon) { create(:pokemon, user: seller, price: 50) }

    context "when the seller is not the owner of the pokemon" do
      before { sign_in seller }

      it "does not update the pokemon and redirects to pokemons_path" do
        post :sell, params: { id: pokemon.id, pokemon: { price: 60 } }
        pokemon.reload
        expect(response).to redirect_to(user_pokemons_path)
        expect(pokemon.user).to eq(seller)
        expect(pokemon.price).to eq(50)
      end
    end

    context "when the seller is the owner of the pokemon" do
      before { sign_in seller }

      context "when there are no buyers with enough balance" do
        before { sign_in seller }

        it "does not update the pokemon and redirects to user_pokemons_path" do
          post :sell, params: { id: pokemon.id, pokemon: { price: 150 } }
          pokemon.reload
          expect(response).to redirect_to(user_pokemons_path)
          expect(pokemon.user).to eq(seller)
          expect(pokemon.price).to eq(50)
          expect(flash[:error]).to eq("No buyers found with enough balance to buy this pokemon")
        end
      end

      context "when there is a buyer with enough balance" do
        before { sign_in seller }

        it "updates the pokemon and redirects to user_pokemons_path" do
          allow(controller).to receive(:random_buyer).and_return(buyer)
          post :sell, params: { id: pokemon.id, pokemon: { price: 60 } }
          pokemon.reload
          seller.reload
          buyer.reload
          expect(response).to redirect_to(user_pokemons_path)
          expect(pokemon.user).to eq(buyer)
          expect(pokemon.price).to eq(60)
          expect(pokemon.last_sell_price).to eq(50)
          expect(seller.balance).to eq(160)
          expect(flash[:error]).to be_nil
        end
      end
    end

    context "when the user is not authenticated" do
      it "redirects to sign in page" do
        post :sell, params: { id: pokemon.id, pokemon: { price: 60 } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end