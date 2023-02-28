class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pokemons
  has_many :transactions

  def has_pokemon?(pokemon)
    pokemons.exists?(pokemon.id)
  end

  def net_worth
    balance + pokemons.sum(:price)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
