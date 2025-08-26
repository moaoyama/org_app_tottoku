class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @document = Document.new
  end
end