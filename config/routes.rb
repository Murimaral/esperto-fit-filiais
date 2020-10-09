Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :plans, only: %i[index new create show]
  resources :subsidiaries, only: %i[index show new create]
  resources :products, only: %i[index show new create]

  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :subsidiaries, only: %i[index]
    end
  end
end
