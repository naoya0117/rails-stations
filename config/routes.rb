Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    root to: redirect('/admin/movies')
    resources :movies, only: %i[index show new create edit update destroy] do
      resources :schedules, only: %i[new show create edit destroy]
    end
    resources :schedules, only: %i[index show update destroy create]
    resources :reservations
  end

  root to: redirect('/movies')

  resources :movies, only: %i[index show] do
    member do
      get :reservation
      resources :schedules, only: [] do
        resources :reservations, only: %i[new create]
      end
    end
  end
  resources :sheets, only: [:index]
  resources :reservations, only: %i[create new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
