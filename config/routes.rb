Rails.application.routes.draw do
  namespace :admin do
    root to: redirect('/admin/movies')
    resources :movies, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :schedules, only: [:new, :show, :create, :edit, :destroy]
    end
    resources :schedules, only: [:index, :show, :update, :destroy, :create]
    resources :reservations
  end

  root to: redirect('/movies')

  resources :movies ,only: [:index, :show] do
    member do
      get :reservation
      resources :schedules, only: [] do
        resources :reservations, only: [:new, :create]
      end
    end
  end
  resources :sheets, only: [:index]
  resources :reservations, only: [:create, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
