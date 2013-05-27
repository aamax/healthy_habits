class HomeController < ApplicationController
  load_and_authorize_resource

  def index
    render "pages/partials/home"
  end
end
