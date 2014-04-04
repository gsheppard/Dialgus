Dialgus::Application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :positions, only: [:index, :new]
  resources :employees, only: [:index]
end
