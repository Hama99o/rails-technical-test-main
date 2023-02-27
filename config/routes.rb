Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :pokemons
  root to: 'pokemons#index'
  get "/pokemon/:id/checkout", to: 'pokemons#checkout', as: :checkout_pokemon
  get "/pokemon/:id/buy", to: 'pokemons#buy', as: :buy_pokemon
  get "/pokemon/:id/sell", to: 'pokemons#sell', as: :sell_pokemon
end
