Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pokemons#landing_page'
  resources :pokemons, only: [:index, :show, :create] do
    member do
      get 'checkout', as: 'checkout'
      post 'buy', as: 'buy'
      patch 'sell', as: 'sell'
    end
  end

  get "/me/add_money", to: 'users#add_money', as: :add_money_screen
  get "/me", to: 'users#me', as: :me
  patch "/me/add", to: 'users#add', as: :add_money
  get "/me/transactions", to: 'users#transactions', as: :user_transactions
  get "/me/user_pokemons", to: 'users#user_pokemons', as: :user_pokemons

end
