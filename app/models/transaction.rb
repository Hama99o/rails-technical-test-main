class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  enum action: { buy: 0, sell: 1 }


  validate :enough_balance, on: :create

  def enough_balance
    if self.buy?
      if self.user.balance < self.pokemon.price
        errors.add(:base, "Not enough balance to buy this pokemon.")
      end
    elsif self.sell?
      # add validation for selling pokemon here
    end
  end
end
