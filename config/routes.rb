Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :subsidiaries, only: %i[index show new create] do
    get :schedule, on: :member
    post :schedule, to: 'subsidiaries#create_schedule', on: :member
    # patch :schedule, to: 'subsidiaries#update_schedule', on: :member
  end
end
