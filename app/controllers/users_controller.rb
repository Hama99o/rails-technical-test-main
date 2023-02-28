class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def user
    @total_pokemon_price = current_user.pokemons.sum(:price)
    @total_balance = current_user.balance + @total_pokemon_price
    @pokemon_count = current_user.pokemons.count
  end

  def add_money
  end

  def user_pokemons
    @pokemons = current_user.pokemons
    @current_user = current_user
  end

  def add
    balance = add_params[:balance]
    @user = @user.update(balance: balance)
    redirect_to user_path
  end

  def transactions
    @transactions = @user.transactions
  end

  def set_user
    @user = current_user
  end

  def add_params
    params.require(:user).permit(:balance)
  end
end
