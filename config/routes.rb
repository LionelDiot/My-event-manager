Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :participations
  resources :events
  resources :users, only: [:index, :show, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"
end
