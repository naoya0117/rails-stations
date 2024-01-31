Rails.application.routes.draw do
  namespace :admin do
    resources :movies, only: [:index]
  end

  resources :movies, only: [:index, :show, :new, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
