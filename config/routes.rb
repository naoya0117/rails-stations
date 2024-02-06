Rails.application.routes.draw do
  namespace :admin do
    root to: redirect('/admin/movies')
    resources :movies, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :schedules, only: [:new, :show, :create, :edit, :destroy]
    end
    resources :schedules, only: [:index, :show, :update, :destroy]
  end

  root to: redirect('/movies')

  resources :movies, only: [:index, :show]
  resource :sheets, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
