RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## 管理者以外はアクセス拒否
  config.authorize_with do
    unless current_user&.admin?
      flash[:alert] = "管理者のみアクセスできます"
      redirect_to main_app.root_path
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.label_methods << :html_safe
  config.asset_source = :sprockets 
  config.main_app_name = ["とっとく？", "管理画面"]
  config.browser_validations = false
  config.navigation_static_links = {
    'アプリ画面に戻る' => 'http://127.0.0.1:3000/home' 
  }
end
