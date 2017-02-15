class HomeController < ApplicationController
  def show
    gon.available_cities = Couch.available_cities
  end
end
