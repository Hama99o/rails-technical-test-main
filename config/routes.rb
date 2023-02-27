Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pokemons#landing_page'
  resources :pokemons, only: [:index, :show, :create] do
    member do
      get 'checkout', as: 'checkout'
      post 'buy', as: 'buy'
      post 'sell', as: 'sell'
    end
  end

  get "/me/add", to: 'users#add', as: :add_money_screen
  put "/me/add", to: 'users#add', as: :add_money
  get "/me/transactions", to: 'users#transactions', as: :user_transactions
end
