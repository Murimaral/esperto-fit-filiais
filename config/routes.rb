Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :enrollments, only: %i[index show] do
    resources :banned_customers, only: %i[new create]
    get 'search', on: :collection
  end
  resources :plans, only: %i[index new create show edit update]
  resources :profiles, only: %i[index show new create]
  resources :enrollments, only: %i[index show] do
    patch 'cancel', on: :member
    resources :banned_customers, only: %i[new create]
  end
  resources :subsidiaries, only: %i[index show new create] do
    resources :subsidiary_plans, only: %i[new create]
    resources :subsidiary_products, only: %i[new create]
    resources :enrollments, only: %i[index show]
    resources :banned_customers, only: %i[show index]
    resource :schedule, only: %i[show new create edit update]
  end
  resources :products, only: %i[index show new create]

  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :subsidiaries, only: %i[index show]
      resources :enrollments, only: %i[create]
    end
  end
end
