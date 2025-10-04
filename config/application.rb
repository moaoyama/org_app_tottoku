require_relative "boot"

require "rails/all"

# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tottoku
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, :ja]
    config.i18n.default_locale = :ja

    require "sprockets/railtie"

    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # エラーページをカスタムコントローラーで処理する設定
    config.exceptions_app = self.routes
  end
end
