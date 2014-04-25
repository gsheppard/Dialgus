Dialgus::Application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :positions, only: [:index, :new, :show, :create, :destroy]
  resources :employees, only: [:index, :create]
  resources :schedules, only: [:index, :create, :show, :update]
  resources :requests, only: [:index, :create]

  post 'create_shifts/:week_id/:employee_id', to: 'schedules#create_shifts', as: 'create_shifts'
end
