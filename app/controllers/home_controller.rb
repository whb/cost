class HomeController < ApplicationController
  def index
    authorize! :show, :home
  end
end
