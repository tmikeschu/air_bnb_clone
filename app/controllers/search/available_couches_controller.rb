class Search::AvailableCouchesController < ApplicationController
  respond_to :html, :js

  def index
    @search_params = search_params
    @query = QueryPresenter.present(search_params)
    @hash = Gmaps4rails.build_markers(@query.couches) do |couch, marker|
      marker.lat couch.latitude
      marker.lng couch.longitude
    end
    gon.available_cities = Couch.available_cities
  end

  private
    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
