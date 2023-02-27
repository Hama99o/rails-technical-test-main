class UsersController < ApplicationController
  before_action :set_me
  before_action :authenticate_user!

  def me
  end

  def add
    p '--------------'
    p params[:balace]
  end

  def transactions
    @transactions = @me.transactions
  end


  def set_me
    @me = current_user
  end
end
