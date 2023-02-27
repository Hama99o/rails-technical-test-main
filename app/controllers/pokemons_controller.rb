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
  end

  def sell
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
