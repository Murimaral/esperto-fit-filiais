Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :plans, only: %i[index new create show]
  resources :subsidiaries, only: %i[index show new create] do
    resources :subsidiary_plans, only: %i[new create]
  end
end
