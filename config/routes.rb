Dialgus::Application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :positions, only: [:index, :new, :show, :create]
  resources :employees, only: [:index, :create]
  resources :schedules, only: [:index, :create, :show, :update]
  resources :requests, only: [:index]
end
