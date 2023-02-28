class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :buy, :sell]
  before_action :random_buyer, only: [:sell]
  before_action :set_current_user
  before_action :authenticate_user!, only: [:buy, :sell]

  def index
    @pokemons = Pokemon.all
    @pokemons = @pokemons.where.not(user_id: current_user.id) if current_user
    @pokemons = @pokemons.where("name ILIKE '%#{params[:search]}%'") if params[:search].present?
  end

  def show
  end

  def landing_page
  end

  def buy
    if current_user.balance < @pokemon.price
      flash[:error] = "You don't have enough balance to buy #{@pokemon.name}."
      redirect_to pokemon_path(@pokemon.id)
    else
      current_user.balance -= @pokemon.price
      current_user.save!

      # Change the pokemon owner
      @pokemon.user = current_user
      @pokemon.save!

      # Change the last_sell_price
      @pokemon.last_sell_price = @pokemon.price
      @pokemon.save!

      # Register a transaction with a BUY operation
      Transaction.create!(
        user: current_user,
        pokemon: @pokemon,
        action: :buy,
        amount: @pokemon.price
      )
      redirect_to user_pokemons_path
    end
  end

  def sell
    price = @pokemon.price

    unless random_buyer
      flash[:error] = "No buyers found with enough balance to buy this pokemon"
      redirect_to user_pokemons_path and return
    end

    if current_user.has_pokemon?(@pokemon)
      transaction = Transaction.new(action: :sell, user: current_user, pokemon: @pokemon)
      if transaction.save
        # Transaction saved successfully
        @pokemon.update(user: random_buyer, price: add_params[:price].to_f, last_sell_price: price)
        current_user.update(balance: current_user.balance + add_params[:price].to_f)
        redirect_to user_pokemons_path
      else
        # Transaction could not be saved
        flash[:error] = "Could not register transaction"
        redirect_to user_pokemons_path
      end
    else
      # Transaction could not be saved
      flash[:error] = "Your are not the owner of this Pokemon"
      redirect_to pokemons_path
    end
  end

  private

  def random_buyer
    price = add_params[:price].to_f
    User.where.not(id: current_user.id).where("balance >= ?", price).sample
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def set_current_user
    @current_user = current_user
  end

  def add_params
    params.require(:pokemon).permit(:price)
  end
end
