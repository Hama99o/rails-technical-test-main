FactoryBot.define do
  factory :transaction do
    user
    pokemon
    action { Transaction.actions.keys.sample }
  end
end