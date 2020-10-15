Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :plans, only: %i[index new create show edit update]
  resources :profiles, only: %i[index show new create]
  resources :enrollments, only: %i[index show] do
    patch 'cancel', to: 'enrollments#cancel'
  end
  resources :subsidiaries, only: %i[index show new create] do
    resources :subsidiary_plans, only: %i[new create]
  end
  resources :products, only: %i[index show new create]

  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :subsidiaries, only: %i[index]
      resources :enrollments, only: %i[create]
    end
  end
end
