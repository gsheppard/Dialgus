Dialgus::Application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :positions, only: [:index, :new]
  resources :employees, only: [:index, :create]
  resources :positions, only: [:show, :create]
  resources :schedules, only: [:index, :create, :show]
end
