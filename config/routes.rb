Rails.application.routes.draw do
  # Deviseのルート（ログイン / サインアップ / ログアウト）
  devise_for :users, class_name: 'User', controllers: {
    sessions: 'users/sessions' # ここで、新しく作ったコントローラーを使うことを教える
  }

  # 管理画面
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # 通常ページ
  get 'home/index'
  get 'static_pages/home'

  # ユーザー関連（表示や編集だけ残す/n&cはDeviseが担当）
  resources :users, only: [:show, :edit, :update]
  
  # Documents関連
  resources :documents, only: [:create, :show, :index, :edit, :update, :destroy] do
    member do
      get :result, as: :result_document
      patch :update_location
      patch :update_user_comment
      patch :update_judgement
      post :upload_image
      get  :edit_image
      delete :delete_image

      patch :update_expiry
    end
  end

  devise_scope :user do
    get 'guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end
  #devise_scope :user do
  #  get '/logout', to: 'devise/sessions#destroy', as: :logout, via: [:get, :post]
  #end

  # resources :documents do
  #   post 'upload_image', on: :member
  #   delete 'delete_image', on: :member
  # end

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