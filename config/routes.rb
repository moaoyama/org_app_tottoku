Rails.application.routes.draw do
  # Deviseのルート
  devise_for :users, class_name: 'User', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # ゲストログイン
  devise_scope :user do
    post 'guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

  # 管理画面
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # 通常ページ
  get 'home/index'
  get 'static_pages/home'

  # ユーザー関連
  resources :users, only: [:show, :edit, :update]
  get '/mypage', to: 'users#show', as: :mypage
  
  # Documents関連
  resources :documents do
    member do
      get :result, as: :result_document
      patch :update_location, :update_user_comment, :update_judgement, :update_expiry
      post :upload_image
      get  :edit_image
      delete :delete_image
    end
  end

  # 健康確認用
  get "up" => "rails/health#show", as: :rails_health_check
  
  # その他ルート
  get '/home', to: 'home#index', as: 'home'
  get '/mypage', to: 'users#show', as: :mypage

  # ルートページ ("/")
  root 'static_pages#home'

  # 独自エラーページ
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end