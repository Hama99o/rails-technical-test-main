Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pokemons#landing_page'
  resources :pokemons, only: [:index, :show, :create] do
    member do
      post 'buy', as: 'buy'
      patch 'sell', as: 'sell'
    end
  end

  get "/user/add_money", to: 'users#add_money', as: :add_money_screen
  get "/user", to: 'users#user', as: :user
  patch "/user/add", to: 'users#add', as: :add_money
  get "/user/transactions", to: 'users#transactions', as: :user_transactions
  get "/user/user_pokemons", to: 'users#user_pokemons', as: :user_pokemons

end
