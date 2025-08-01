class HomeController < ApplicationController
  before_action :require_login

  def index
    @document = Document.new
  end
end
