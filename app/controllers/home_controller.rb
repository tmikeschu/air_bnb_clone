class HomeController < ApplicationController
  def show
    gon.availableCities = Couch.availableCities
  end
end
