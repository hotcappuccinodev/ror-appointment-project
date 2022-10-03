class HomeController < ApplicationController
  def index
    redirect_to '/api-docs'
  end
end
