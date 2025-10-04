# frozen_string_literal: true
# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.paths << Rails.root.join("node_modules/@fortawesome/fontawesome-free/webfonts")
Rails.application.config.assets.precompile += %w( icons/*.svg )