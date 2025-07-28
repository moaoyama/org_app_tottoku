Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  get 'static_pages/home'
  get 'documents/new'
  get 'documents/create'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/new'
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :documents, only: [:new, :create, :show, :index]
  # root "users#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get "/home", to: "home#index"
  get 'documents/:id/result', to: 'documents#result', as: 'document_result'
  get '/mypage', to: 'users#show'

  # Defines the root path route ("/")
  root 'static_pages#home'
end