Rails.application.routes.draw do
  namespace :admin do
    root to: redirect('/admin/movies')
    resources :movies, only: [:index, :new, :create, :edit, :update]
  end
  root to: redirect('/movies')
  resources :movies, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
