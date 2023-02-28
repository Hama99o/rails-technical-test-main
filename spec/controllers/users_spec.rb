
require 'rails_helper'

describe UsersController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:transaction) { FactoryBot.create(:transaction, user: user) }
  before { sign_in user }


  describe "GET user" do
    it "renders the user template" do
      get :user
      expect(response).to render_template(:user)
    end

    it "assigns the correct instance variables" do
      get :user
      expect(assigns(:total_pokemon_price)).to eq(user.pokemons.sum(:price))
      expect(assigns(:total_balance)).to eq(user.balance + user.pokemons.sum(:price))
      expect(assigns(:pokemon_count)).to eq(user.pokemons.count)
    end
  end

  describe "GET add_money" do
    it "renders the add_money template" do
      get :add_money
      expect(response).to render_template(:add_money)
    end
  end

  describe "GET user_pokemons" do
    it "renders the user_pokemons template" do
      get :user_pokemons
      expect(response).to render_template(:user_pokemons)
    end
  end

  describe "POST add" do
    context "with valid params" do
      it "updates the user's balance" do
        post :add, params: { user: { balance: 100 } }
        expect(user.reload.balance).to eq(100)
      end
      it "redirects to the user page" do
        post :add, params: { user: { balance: 100 } }
        expect(response).to redirect_to(user_path)
      end
    end
  end

  describe "GET transactions" do
    it "renders the transactions template" do
      get :transactions
      expect(response).to render_template(:transactions)
    end

    it "assigns the correct instance variables" do
      get :transactions
      expect(assigns(:transactions)).to eq(user.transactions)
    end
  end
end