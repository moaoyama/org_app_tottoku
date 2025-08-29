# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/ujs", to: "@rails--ujs.js", preload: true
pin "hamburger_toggle", to: "hamburger_toggle.js", preload: true
pin "custom/modal", to: "custom/modal.js", preload: true
pin "rails_admin", to: "rails_admin.js", preload: true
pin "custom/image_upload", to: "custom/image_upload.js"