class ErrorsController < ApplicationController
  # 404 Not Found
  def not_found
    render status: :not_found
  end

  # 500 Internal Server Error
  def internal_server_error
    render status: :internal_server_error
  end
end