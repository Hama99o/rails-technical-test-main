class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :checkout, :buy, :sell]
  before_action :authenticate_user!, only: [:checkout, :buy, :sell]

  def index
    @pokemons = Pokemon.all
    @pokemons = @pokemons.where("name ILIKE '%#{params[:search]}%'") if params[:search].present?
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def checkout
    @pokemon = Pokemon.find(params[:id])
  end


  def landing_page
  end

  def buy
    price = @pokemon.price
    if current_user.balance >= price
      Transaction.create(action: :buy, user: current_user, pokemon: @pokemon)
      current_user.update(balance: current_user.balance - price)
    elseif current_user.pokemon.id == @pokemon.id
      flash[:error] = "you already have that pokemon"
    else
      flash[:error] = "you dont have enough money"
    end
  end

  def sell
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
