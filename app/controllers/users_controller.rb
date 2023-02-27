class UsersController < ApplicationController
  before_action :set_me
  before_action :authenticate_user!

  def me
  end

  def add_money
  end

  def user_pokemons
    @pokemons = current_user.pokemons
    @current_user = current_user
  end

  def add
    balance = add_params[:balance]
    @me = @me.update(balance: balance)
    redirect_to me_path
  end

  def transactions
    @transactions = @me.transactions
  end

  def set_me
    @me = current_user
  end

  def add_params
    params.require(:user).permit(:balance)
  end
end
