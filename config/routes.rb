Rails.application.routes.draw do
  # Deviseのルート（ログイン / サインアップ / ログアウト）
  devise_for :users

  # 管理画面
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # 通常ページ
  get 'home/index'
  get 'static_pages/home'

  # ユーザー関連（表示や編集だけ残す/n&cはDeviseが担当）
  resources :users, only: [:show, :edit, :update]
  
  # Documents関連
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

  # resources :documents do
  #   post 'upload_image', on: :member
  #   delete 'delete_image', on: :member
  # end

  # 健康確認用
  get "up" => "rails/health#show", as: :rails_health_check
  
  # その他ルート
  get '/home', to: 'home#index', as: 'home'
  post "/result", to: "documents#result", as: "judge_result"
  # get 'documents/:id/result', to: 'documents#result', as: 'document_result'
  get '/mypage', to: 'users#show', as: :mypage

  # ルートページ ("/")
  root 'static_pages#home'
end