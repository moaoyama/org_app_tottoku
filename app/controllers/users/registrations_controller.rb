# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    home_path(resource)
  end

  def after_update_path_for(resource)
    home_path(resource)
  end
end