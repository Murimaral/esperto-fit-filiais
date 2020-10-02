Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :subsidiaries, only: %i[index show new create]
  resources :products, only: %i[index show new create]
end
