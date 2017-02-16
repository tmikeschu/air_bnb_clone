class Search::AvailableCouchesController < ApplicationController
  respond_to :html, :js

  def index
    @search_params = search_params
    @query = QueryPresenter.present(search_params)
    gon.available_cities = Couch.available_cities
  end

  private
    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
