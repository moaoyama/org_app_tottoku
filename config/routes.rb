Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  get 'static_pages/home'

  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :documents, only: [:create, :show, :result, :index, :edit, :update, :destroy] do
    member do
      get :result
      patch :update_location
      patch :update_user_comment
      patch :update_judgement
      post :upload_image
      get  :edit_image
      delete :delete_image
    end
  end

  resources :documents do
    post 'upload_image', on: :member
    delete 'delete_image', on: :member
  end

  # root "users#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  
  get '/home', to: 'home#index', as: 'home'
  
  post "/result", to: "documents#result", as: "judge_result"
  # get 'documents/:id/result', to: 'documents#result', as: 'document_result'
  get '/mypage', to: 'users#show', as: :mypage
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'

  # Defines the root path route ("/")
  root 'static_pages#home'
end