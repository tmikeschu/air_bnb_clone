class Search::AvailableCouchesController < ApplicationController
  protect_from_forgery except: :update
  respond_to :html, :js

  def index
    @search_params = search_params
    @query = QueryPresenter.present(search_params)
    @couches = @query.couches.paginate(page: params[:page], per_page: 4)
    gon.available_cities = Couch.available_cities
  end

  private
    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
