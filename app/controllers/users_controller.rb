class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
  end

  def add
  end

  def transactions
  end
end
