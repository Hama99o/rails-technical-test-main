Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pokemons#landing_page'
  resources :pokemons, only: [:index, :show, :create] do
    member do
      get 'checkout', as: 'checkout'
      get 'buy', as: 'buy'
      get 'sell', as: 'sell'
    end
  end
end
