class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
    @pokemons = @pokemons.where("name ILIKE '%#{params[:search]}%'") if params[:search].present?
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
